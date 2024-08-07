# https://docs.rancher.cn/docs/k3s/installation/install-options/server-config/_index/
{
  config,
  pkgs,
  lib,
  ...
}: let
  name = config.networking.hostName;
  cfg = config.services.k3s;
in {
  sops.secrets = {
    # "k3s/tailscale" = {};
    "k3s/env".sopsFile = ../secrets/${name}.yaml;
    "k3s/extras".sopsFile = ../secrets/${name}.yaml;
    "etcd/cert.pem" = {};
    "etcd/key.pem" = {};
    "etcd/ca.crt" = {};
  };

  systemd.services."conf-kmsg" = lib.mkIf config.islxc {
    wantedBy = ["default.target"];
    description = "LXC link kmsg";
    path = [pkgs.util-linux];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeScript "conf-kmsg" ''
        #!/bin/sh
        if [ ! -e /dev/kmsg ]; then
            ln -s /dev/console /dev/kmsg
        fi
        mount --make-rshared /
      '';
      TimeoutStartSec = 0;
      RemainAfterExit = true;
    };
  };

  networking.firewall.allowedTCPPorts = [6443];
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  # networking.firewall.extraCommands = ''
  #   iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -d 100.99.0.0/16 -j MASQUERADE
  # '';

  # disable: servicelb traefik
  systemd.services.k3s = {
    path = [pkgs.coreutils pkgs.curl];
    after = ["sops-nix.service" "wireguard.service"];
    # serviceConfig.ExecStart = lib.mkForce (pkgs.writeScript "k3s-wrap" ''
    #   #!/bin/sh
    #   extraFlags=$(cat ${config.sops.secrets."k3s/extras".path})
    #   # hostIP=$(curl -4 ip.sb)
    #   # echo --node-external-ip=$hostIP $extraFlags | xargs \
    #   echo $extraFlags | xargs \
    #     ${cfg.package}/bin/k3s ${cfg.role} \
    #     --resolv-conf=/etc/resolv.conf ${
    #     if (!config.isagent)
    #     then ''
    #       --disable metrics-server \
    #       --cluster-cidr=10.42.0.0/16,2001:cafe:42:0::/56 \
    #       --service-cidr=10.43.0.0/16,2001:cafe:42:1::/112 \
    #       --tls-san=${name},${name}.jerrita.cn,apiserver
    #     ''
    #     else ""
    #   }
    # '');
  };

  services.k3s = {
    enable = true;
    package = pkgs.k3s_1_30;
    role =
      if config.isagent
      then "agent"
      else "server";
    environmentFile = config.sops.secrets."k3s/env".path;
    extraFlags = ''
      --resolv-conf=/etc/resolv.conf ${
        if (config.useWg)
        then "--flannel-iface=wg0"
        else ""
      } ${
        if (!config.isagent)
        then ''
          --disable metrics-server \
          --cluster-cidr=10.42.0.0/16,2001:cafe:42:0::/56 \
          --service-cidr=10.43.0.0/16,2001:cafe:42:1::/112 \
          --tls-san=${name},${name}.jerrita.cn,apiserver \
          --flannel-backend=host-gw
        ''
        else ""
      }
    '';
  };
}
