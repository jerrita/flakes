{
  pkgs,
  config,
  ...
}: let
  user = "hyst";
in {
  users.users."${user}" = {
    isSystemUser = true;
    group = "${user}";
  };
  users.groups."${user}" = {};

  networking.firewall.allowedUDPPorts = [443];
  networking.firewall.allowedTCPPorts = [443];
  sops = {
    secrets = {
      uuid = {};
      "server.crt".owner = "${user}";
      "server.key".owner = "${user}";
    };
    templates."hyst.yaml" = {
      owner = "${user}";
      content = ''
        listen: :443

        tls:
          cert: ${config.sops.secrets."server.crt".path}
          key: ${config.sops.secrets."server.key".path}

        auth:
          type: password
          password: ${config.sops.placeholder.uuid}

        masquerade:
          type: proxy
          proxy:
            url: https://bing.com/
            rewriteHost: true
      '';
    };
  };
  systemd.services.hysteria = {
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target" "sops-nix.service"];
    after = ["sops-nix.service"];
    description = "Hysteria Service";
    serviceConfig = {
      User = "${user}";
      ExecStart = "${pkgs.hysteria}/bin/hysteria server -c ${config.sops.templates."hyst.yaml".path}";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
    };
  };
  environment.systemPackages = [pkgs.hysteria];
}
