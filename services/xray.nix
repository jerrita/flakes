{config, ...}: {
  users.users."xray".isNormalUser = true;
  sops.secrets.uuid = {};
  sops.secrets.reality = {};
  sops.templates."xray.json" = {
    content = ''
      {
          "log": {
              "access": "none",
              "loglevel": "error"
          },
          "inbounds": [
              {
                  "port": 7137,
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
                  "domainStrategy": "UseIPv6v4"
              }
          ]
      }
    '';
    owner = "xray";
  };

  services.xray = {
    enable = true;
    settingsFile = config.sops.templates."xray.json".path;
  };

  systemd.services.xray.serviceConfig = {
    User = "xray";
  };
}
