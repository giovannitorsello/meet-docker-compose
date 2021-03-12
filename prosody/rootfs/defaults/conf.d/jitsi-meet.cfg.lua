admins = {
    "${JICOFO_AUTH_USER}@${XMPP_AUTH_DOMAIN}",
    "${JVB_AUTH_USER}@${XMPP_AUTH_DOMAIN}",
    "${JVB_BREWERY_MUC}@${XMPP_AUTH_DOMAIN}"
}

plugin_paths = { "/prosody-plugins/", "/prosody-plugins-custom" }
http_default_host = "${XMPP_DOMAIN}"

cross_domain_websocket = { "${PUBLIC_URL}" };
consider_bosh_secure = true;


-- XMPP domain definition and components
VirtualHost "${XMPP_DOMAIN}"
    authentication = "anonymous"
    allow_anonymous_s2s = true
    allow_anonymous_c2s = true
    -- authentication = "${JWT_AUTH_TYPE}"
    -- app_id = "${JWT_APP_ID}"
    -- app_secret = "${JWT_APP_SECRET}"
    -- authentication = "anonymous"
    -- allow_empty_token = true;
    
    ssl = {
        key = "/etc/prosody/certs/${XMPP_DOMAIN}.key";
        certificate = "/etc/prosody/certs/${XMPP_DOMAIN}.crt";
    }
    modules_enabled = {
        "bosh";
        "mod_turncredentials";
        "websocket";
        "smacks";
        "pubsub";
        "ping";
        "speakerstats";
        "conference_duration";
        -- "muc_lobby_rooms";
        "auth_cyrus";        
    }    

    main_muc = "${XMPP_MUC_DOMAIN}"
    -- lobby_muc = "lobby.${XMPP_DOMAIN}"
    -- muc_lobby_whitelist = { "${XMPP_RECORDER_DOMAIN}" }
    speakerstats_component = "speakerstats.${XMPP_DOMAIN}"
    conference_duration_component = "conferenceduration.${XMPP_DOMAIN}"
    c2s_require_encryption = false

Component "focus.${XMPP_DOMAIN}"
    component_secret = "${JICOFO_COMPONENT_SECRET}"

Component "speakerstats.${XMPP_DOMAIN}" "speakerstats_component"
    muc_component = "${XMPP_MUC_DOMAIN}"

Component "conferenceduration.${XMPP_DOMAIN}" "conference_duration_component"
    muc_component = "${XMPP_MUC_DOMAIN}"

-- Component "lobby.${XMPP_DOMAIN}" "muc"
--   storage = "memory"
--    restrict_room_creation = true
--    muc_room_locking = false
--    muc_room_default_public_jids = true

-- Auth domain definition and components
VirtualHost "${XMPP_AUTH_DOMAIN}"
    ssl = {
        key = "/etc/prosody/certs/${XMPP_AUTH_DOMAIN}.key";
        certificate = "/etc/prosody/certs/${XMPP_AUTH_DOMAIN}.crt";
    }    
    authentication = "internal_hashed"


VirtualHost "${XMPP_GUEST_DOMAIN}"
    authentication = "anonymous"
    allow_anonymous_s2s = true
    c2s_require_encryption = false
    
    modules_enabled = {
        "muc_lobby_rooms";        
    }    
    main_muc = "${XMPP_MUC_DOMAIN}"    

VirtualHost "${XMPP_RECORDER_DOMAIN}"
    modules_enabled = {
      "ping";
    }
    authentication = "internal_hashed"

Component "${XMPP_INTERNAL_MUC_DOMAIN}" "muc"
    storage = "memory"
    modules_enabled = {
        "ping";
    }
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "${XMPP_MUC_DOMAIN}" "muc"
    modules_enabled = {
        "muc_meeting_id";
    }
    storage = "memory"
    muc_room_cache_size = 1000
    muc_room_locking = false
    muc_room_default_public_jids = true

