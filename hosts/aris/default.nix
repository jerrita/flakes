{
  modulesPath,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware.nix

    ../../services/k3s.nix
    ./wstunnel.nix

    ../../modules/nix-core.nix
    ../../modules/cntime.nix
    ../../modules/sops.nix
    ../../modules/zram.nix
    ../../modules/sys.nix
    ../../modules/vps.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  services.qemuGuest.enable = true;

  time.timeZone = "Asia/Shanghai";
  networking.hostName = "aris";
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".text = "nameserver 192.168.5.1\n";
  networking.firewall.trustedInterfaces = ["eth0"];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6m8fiwUgm+iSczcsBm/mzH2yoyjiFvlUSs4N4U7urU jerrita@Jerrita-Air"
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.05";
}
