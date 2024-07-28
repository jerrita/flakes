{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ../../modules/disk-config.nix
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

  services.openssh.settings.PermitRootLogin = true;
  users.users.root = {
    # Password: bootstrap
    hashedPassword = "$y$j9T$YmBq2sedi2MiiYavxL/2s/$mZRegovXZ2moAsg91gKzSoDs//DtOk41roROqJkf4JA";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIlhieGV556BnkvCUDWev/awcmdxgjAgLT2VOuFPaIqa jerrita@dev"
    ];
  };

  system.stateVersion = "24.05";
}
