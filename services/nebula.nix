{config, ...}: let
  name = config.networking.hostName;
  user = config.systemd.services."nebula@lycoreco".serviceConfig.User;
in {
  sops = {
    secrets = {
      "ca.crt".owner = user;
      "${name}.crt" = {
        owner = user;
        sopsFile = ../secrets/${name}.yaml;
      };
      "${name}.key" = {
        owner = user;
        sopsFile = ../secrets/${name}.yaml;
      };
    };
  };

  networking.firewall.trustedInterfaces = ["lycoreco"];

  systemd.services."nebula@lycoreco" = {
    wants = ["network-online.target"];
    after = ["network-online.target"];
    # path = with pkgs; [bash iproute2 gnugrep coreutils gawk];
    # postStart = ''
    #   #!/usr/bin/env bash
    #   ipv6_address=$(ip -6 addr show dev eth0 | grep 'inet6' | grep -v 'link' | awk '{print $2}' | cut -d/ -f1)
    #   if [ -z "$ipv6_address" ]; then
    #     echo "No IPv6 address found on eth0"
    #     exit 1
    #   fi
    #   ip -6 addr add "$ipv6_address"/64 dev lycoreco
    #   echo "IPv6 address $ipv6_address assigned to nebula interface."
    # '';
  };

  services.nebula.networks."lycoreco" = {
    enable = true;
    key = config.sops.secrets."${name}.key".path;
    cert = config.sops.secrets."${name}.crt".path;
    ca = config.sops.secrets."ca.crt".path;
    tun.device = "lycoreco";
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
