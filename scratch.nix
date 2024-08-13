# Use for firsh install
# nixos-install --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store"
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./modules/tunnel.nix
  ];

  nix.settings.substituters = ["https://mirrors.ustc.edu.cn/nix-channels/store"];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "scratch";
  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    vim
    wget
    gitMinimal
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root = {
    # Password: bootstrap
    hashedPassword = "$y$j9T$YmBq2sedi2MiiYavxL/2s/$mZRegovXZ2moAsg91gKzSoDs//DtOk41roROqJkf4JA";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6m8fiwUgm+iSczcsBm/mzH2yoyjiFvlUSs4N4U7urU jerrita@Jerrita-Air"
    ];
  };

  system.stateVersion = "24.05";
}
