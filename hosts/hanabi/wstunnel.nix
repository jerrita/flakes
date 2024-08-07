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
      ExecStart = "${wstunnel}/bin/wstunnel server --restrict-to 192.168.5.1:13231 wss://[::]:51820";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
