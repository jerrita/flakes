{
  config,
  pkgs,
  lib,
  ...
}: let
  name = config.networking.hostName;
in {
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
  systemd.services.k3s.after = ["nebula@lycoreco.service"];
  services.k3s = {
    enable = true;
    package = pkgs.k3s_1_29;
    role =
      if config.isagent
      then "agent"
      else "server";
    serverAddr = lib.mkIf config.isagent "10.99.1.1";
    extraFlags = ''
      --data-dir=/data/rancher \
      --advertise-address=10.99.1.1 \
      --cluster-cidr="10.42.0.0/16,2001:cafe:42::/56" \
      --service-cidr="10.43.0.0/16,2001:cafe:42::/112" \
      --tls-san=${name},${name}.jerrita.cn --resolv-conf=/etc/resolv.conf \
      --flannel-backend=host-gw
    '';
  };
}
