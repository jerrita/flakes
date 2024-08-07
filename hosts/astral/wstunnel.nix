{config, ...}: let
  wstunnel = config.nur.repos.jerrita.wstunnel;
in {
  networking.firewall.allowedTCPPorts = [51820];
  environment.systemPackages = [wstunnel];
  systemd.services.wstunnel = {
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${wstunnel}/bin/wstunnel client \
        -L 'udp://13231:192.168.5.1:13231?timeout_sec=0' \
        wss://lab.jerrita.cn:51820
      '';
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
