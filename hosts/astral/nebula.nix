{config, ...}: let
  name = "astral";
  user = config.systemd.services."nebula@lycoreco".serviceConfig.User;
in {
  sops = {
    secrets = {
      "ca.crt".owner = user;
      "${name}.crt" = {
        owner = user;
        sopsFile = ../../secrets/${name}.yaml;
      };
      "${name}.key" = {
        owner = user;
        sopsFile = ../../secrets/${name}.yaml;
      };
    };
  };

  services.nebula.networks."lycoreco" = {
    enable = true;
    key = config.sops.secrets."${name}.key".path;
    cert = config.sops.secrets."${name}.crt".path;
    ca = config.sops.secrets."ca.crt".path;
    tun.device = "lycoreco";
    isLighthouse = true;
    isRelay = true;
    firewall = {
      outbound = [
        {
          host = "any";
          port = "any";
          proto = "any";
        }
      ];
      inbound = [
        {
          host = "any";
          port = "any";
          proto = "any";
        }
      ];
    };
  };
}
