{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware.nix

    # ./pgsql.nix
    # ./etcd.nix
    # ./edge.nix
    ./wstunnel.nix
    ../../services/xray.nix
    ../../services/wireguard.nix
    ../../services/k3s.nix

    # ../../modules/fhs.nix
    ../../modules/nix-core.nix
    ../../modules/zram.nix
    ../../modules/vps.nix
    ../../modules/sys.nix
    ../../modules/sops.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  services.openssh.enable = true;
  services.openssh.ports = [2222];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  time.timeZone = "Asia/Shanghai";
  networking.hostName = "astral";
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".text = "nameserver 8.8.8.8\n";

  networking.extraHosts = ''
    192.168.5.68 cloud.lan
    192.168.5.67 emby.lan
  '';

  programs.zsh.enable = true;

  documentation = {
    man.enable = true;
    dev.enable = false;
    doc.enable = false;
    nixos.enable = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6m8fiwUgm+iSczcsBm/mzH2yoyjiFvlUSs4N4U7urU jerrita@Jerrita-Air"
  ];

  system.stateVersion = "24.05";
}
