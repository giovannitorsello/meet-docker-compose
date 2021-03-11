admins = {
    "focus@auth.meet.local",
    "jvb@auth.meet.local",
    "@auth.meet.local"
}

plugin_paths = { "/prosody-plugins/", "/prosody-plugins-custom" }
http_default_host = "meet.local"

cross_domain_websocket = { "https://meet.local" };
consider_bosh_secure = true;

VirtualHost "meet.local"
    -- authentication = "token"
    -- app_id = "dfsjdfs8723983y4fsfh298347jdfsjksw"
    -- app_secret = "dfkljsdfklsj3892893472893DFJSKLDFJKLSDJ309420SDKFJKLS"
    authentication = "anonymous"
    allow_empty_token = true;
    
    ssl = {
        key = "/etc/prosody/certs/meet.local.key";
        certificate = "/etc/prosody/certs/meet.local.crt";
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

    main_muc = "muc.meet.local"
    lobby_muc = "lobby.meet.local"
    muc_lobby_whitelist = { "recorder.meet.torsello.ovh" }
    speakerstats_component = "speakerstats.meet.local"
    conference_duration_component = "conferenceduration.meet.local"

    c2s_require_encryption = false

VirtualHost "guest.meet.local"
    authentication = "anonymous"
    app_id = ""
    app_secret = ""
    allow_empty_token = true
    c2s_require_encryption = false
    modules_enabled = {
        "muc_lobby_rooms";
    }

    main_muc = "muc.meet.local"
    lobby_muc = "lobby.meet.local"
    muc_lobby_whitelist = { "recorder.meet.torsello.ovh" }
    
VirtualHost "auth.meet.local"
    ssl = {
        key = "/etc/prosody/certs/auth.meet.local.key";
        certificate = "/etc/prosody/certs/auth.meet.local.crt";
    }
    authentication = "internal_hashed"

VirtualHost "recorder.meet.torsello.ovh"
    modules_enabled = {
      "ping";
    }
    authentication = "internal_hashed"

Component "internal-muc.meet.local" "muc"
    storage = "memory"
    modules_enabled = {
        "ping";
    }
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "muc.meet.local" "muc"
    storage = "memory"
    -- modules_enabled = {
    --    "muc_meeting_id";
    --    "token_verification";
    --}
    muc_room_cache_size = 1000
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "focus.meet.local"
    component_secret = "aad4d97c67ed9624ef253236055218ec"

Component "speakerstats.meet.local" "speakerstats_component"
    muc_component = "muc.meet.local"

Component "conferenceduration.meet.local" "conference_duration_component"
    muc_component = "muc.meet.local"

Component "lobby.meet.local" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "conference.meet.local" "muc"
    storage = "memory"
    restrict_room_creation = false
    muc_room_locking = false
    muc_room_default_public_jids = true

