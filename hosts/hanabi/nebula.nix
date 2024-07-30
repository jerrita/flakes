{config, ...}: let
  name = "hanabi";
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

  systemd.services."nebula@lycoreco" = {
    wants = ["network-online.target"];
    after = ["network-online.target"];
  };
  services.nebula.networks."lycoreco" = {
    enable = true;
    key = config.sops.secrets."${name}.key".path;
    cert = config.sops.secrets."${name}.crt".path;
    ca = config.sops.secrets."ca.crt".path;
    tun.device = "lycoreco";
    isRelay = true;
    staticHostMap = {
      "10.99.2.1" = [
        "astral.jerrita.cn:4242"
      ];
    };
    lighthouses = ["10.99.2.1"];
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
