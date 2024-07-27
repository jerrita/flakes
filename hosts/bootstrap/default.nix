{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ../../modules/disk-config.nix
    ../../modules/nix-core.nix
  ];

  boot.loader.grub = {
    device = "/dev/vda";
  };
  services.openssh.enable = true;

  time.timeZone = "Asia/Shanghai";
  services.resolved.enable = false;

  networking.nameservers = ["8.8.8.8"];
  networking.hostName = "bootstrap";

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

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
