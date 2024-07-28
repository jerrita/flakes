{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ../../services/xray.nix
    ../../services/hysteria.nix

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

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  time.timeZone = "Asia/Shanghai";

  networking.hostName = "rana";
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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIlhieGV556BnkvCUDWev/awcmdxgjAgLT2VOuFPaIqa jerrita@dev"
  ];

  system.stateVersion = "24.05";
}
