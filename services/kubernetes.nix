{
  config,
  pkgs,
  lib,
  ...
}: let
  kubeMasterIP = "192.168.5.79";
  kubeMasterHostname = "hanabi";
  kubeMasterAPIServerPort = 6443;
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

  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.flannel.backend = {Type = "host-gw";};
  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;

    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    addons.dns.enable = true;

    clusterCidr = "10.42.0.0/16,2001:cafe:42::/56";
    apiserver.serviceClusterIpRange = "10.43.0.0/16,2001:cafe:43::/112";

    kubelet = {
      address = "::";
      failSwapOn = false;
    };
  };
}
