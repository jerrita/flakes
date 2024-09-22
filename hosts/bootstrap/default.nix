{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./disk.nix

    ../../modules/nix-core.nix
    ../../modules/zram.nix
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

  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root = {
    # Password: bootstrap
    hashedPassword = "$y$j9T$YmBq2sedi2MiiYavxL/2s/$mZRegovXZ2moAsg91gKzSoDs//DtOk41roROqJkf4JA";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6m8fiwUgm+iSczcsBm/mzH2yoyjiFvlUSs4N4U7urU jerrita@Jerrita-Air"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsLDKu3yjeLyqhEE45FiUvo1EdyfN+pRSACEY/N4j5B dev@misakinet"
    ];
  };

  system.stateVersion = "24.05";
}
