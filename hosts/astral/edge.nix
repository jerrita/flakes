{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    config.nur.repos.jerrita.kubeedge
    # pkgs.cni-plugin-flannel
    # pkgs.cni-plugins
  ];

  # virtualisation.containerd.enable = true;
  # virtualisation.containerd.settings = {
  #   version = 2;
  #   plugins."io.containerd.grpc.v1.cri" = {
  #     # cni.conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
  #     cni.bin_dir = "${pkgs.runCommand "cni-bin-dir" {} ''
  #       mkdir -p $out
  #       ln -sf ${pkgs.cni-plugins}/bin/* ${pkgs.cni-plugin-flannel}/bin/* $out
  #     ''}";
  #   };
  # };
  # systemd.services.containerd.path = [pkgs.runc];

  virtualisation.cri-o = {
    enable = true;
    pauseImage = "kubeedge/pause:3.6";
  };

  boot.kernel.sysctl = {
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.ipv4.ip_forward" = 1;
    "net.bridge.bridge-nf-call-ip6tables" = 1;
  };

  systemd.services.edgecore = {
    wants = ["network-online.target" "wireguard.service" "crio.service"];
    after = ["network-online.target" "wireguard.service" "crio.service"];
    path = with pkgs; [
      gitMinimal
      openssh
      util-linux
      iproute2
      ethtool
      thin-provisioning-tools
      iptables
      socat
    ];
    serviceConfig = {
      Type = "exec";
      KillMode = "process";
      Delegate = "yes";
      Restart = "always";
      RestartSec = "5s";
      LimitNOFILE = 1048576;
      LimitNPROC = "infinity";
      LimitCORE = "infinity";
      TasksMax = "infinity";
      ExecStart = "${config.nur.repos.jerrita.kubeedge}/bin/edgecore";
    };
  };
}
