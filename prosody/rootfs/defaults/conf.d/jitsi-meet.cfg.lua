admins = {
    "${JICOFO_AUTH_USER}@${XMPP_AUTH_DOMAIN}",
    "${JVB_AUTH_USER}@${XMPP_AUTH_DOMAIN}"
}

plugin_paths = { "/prosody-plugins/", "/prosody-plugins-custom" }
http_default_host = "${XMPP_DOMAIN}"

cross_domain_websocket = { "${PUBLIC_URL}" };
consider_bosh_secure = true;

VirtualHost "${XMPP_DOMAIN}"
    -- authentication = "${JWT_AUTH_TYPE}"
    -- app_id = "${JWT_APP_ID}"
    -- app_secret = "${JWT_APP_SECRET}"
    authentication = "anonymous"
    allow_empty_token = true;
    
    ssl = {
        key = "/etc/prosody/certs/${XMPP_DOMAIN}.key";
        certificate = "/etc/prosody/certs/${XMPP_DOMAIN}.crt";
    }
    modules_enabled = {
        "bosh";
        "websocket";
        "smacks";
        "pubsub";
        "ping";
        "speakerstats";
        "conference_duration";
        "muc_lobby_rooms";
        "auth_cyrus";        
    }

    main_muc = "${XMPP_MUC_DOMAIN}"
    lobby_muc = "lobby.${XMPP_DOMAIN}"
    muc_lobby_whitelist = { "${XMPP_RECORDER_DOMAIN}" }
    speakerstats_component = "speakerstats.${XMPP_DOMAIN}"
    conference_duration_component = "conferenceduration.${XMPP_DOMAIN}"

    c2s_require_encryption = false

VirtualHost "${XMPP_GUEST_DOMAIN}"
    authentication = "anonymous"
    app_id = ""
    app_secret = ""
    allow_empty_token = true
    c2s_require_encryption = false
    modules_enabled = {
        "muc_lobby_rooms";
    }

    main_muc = "${XMPP_MUC_DOMAIN}"
    lobby_muc = "lobby.${XMPP_DOMAIN}"
    muc_lobby_whitelist = { "${XMPP_RECORDER_DOMAIN}" }
    
VirtualHost "${XMPP_AUTH_DOMAIN}"
    ssl = {
        key = "/etc/prosody/certs/${XMPP_AUTH_DOMAIN}.key";
        certificate = "/etc/prosody/certs/${XMPP_AUTH_DOMAIN}.crt";
    }
    authentication = "internal_hashed"

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
    storage = "memory"
    modules_enabled = {
        "muc_meeting_id";
        "${JWT_TOKEN_AUTH_MODULE}";
    }
    muc_room_cache_size = 1000
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "focus.${XMPP_DOMAIN}"
    component_secret = "${JICOFO_COMPONENT_SECRET}"

Component "speakerstats.${XMPP_DOMAIN}" "speakerstats_component"
    muc_component = "${XMPP_MUC_DOMAIN}"

Component "conferenceduration.${XMPP_DOMAIN}" "conference_duration_component"
    muc_component = "${XMPP_MUC_DOMAIN}"

Component "lobby.${XMPP_DOMAIN}" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_locking = false
    muc_room_default_public_jids = true
