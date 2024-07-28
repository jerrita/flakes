{config, ...}: let
  user = "xray";
in {
  users.users."${user}" = {
    isSystemUser = true;
    group = "${user}";
  };
  users.groups."${user}" = {};

  networking.firewall.allowedTCPPorts = [7137];
  sops = {
    secrets = {
      uuid = {};
      reality = {};
    };
    templates."xray.json" = {
      owner = "${user}";
      content = ''
        {
            "log": {
                "access": "none",
                "loglevel": "warning"
            },
            "inbounds": [
                {
                    "port": 7137,
                    "listen": "0.0.0.0",
                    "protocol": "vless",
                    "settings": {
                        "clients": [
                            {
                                "id": "${config.sops.placeholder.uuid}",
                                "flow": "xtls-rprx-vision"
                            }
                        ],
                        "decryption": "none"
                    },
                    "streamSettings": {
                        "network": "tcp",
                        "security": "reality",
                        "realitySettings": {
                            "dest": "swcdn.apple.com:443",
                            "serverNames": [
                                "swcdn.apple.com"
                            ],
                            "privateKey": "${config.sops.placeholder.reality}",
                            "shortIds": [
                                "114514"
                            ]
                        }
                    },
                    "sniffing": {
                        "enabled": true,
                        "destOverride": [
                            "http",
                            "tls",
                            "quic"
                        ],
                        "routeOnly": true
                    }
                }
            ],
            "outbounds": [
                {
                    "protocol": "freedom",
                    "domainStrategy": "UseIPv4v6"
                }
            ]
        }
      '';
    };
  };

  services.xray = {
    enable = true;
    settingsFile = config.sops.templates."xray.json".path;
  };
  systemd.services.xray.serviceConfig.User = "${user}";
}
