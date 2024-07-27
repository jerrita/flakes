{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ../../modules/nix-core.nix
    ../../modules/user.nix
    ../../modules/zram.nix
    ../../modules/vps.nix
    ../../modules/sys.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };
  services.openssh.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  time.timeZone = "Asia/Shanghai";

  networking.hostName = "astral";
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".text = "nameserver 8.8.8.8\n";

  programs.zsh.enable = true;

  documentation = {
    man.enable = true;
    dev.enable = false;
    doc.enable = false;
    nixos.enable = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINu+Alullj1Meq+a3KNFlIT9lU9YCb8WDr/mZhHCEPji jerrita@mac-air"
  ];

  system.stateVersion = "24.05";
}
