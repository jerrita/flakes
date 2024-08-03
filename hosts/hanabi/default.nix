{
  modulesPath,
  pkgs,
  lib,
  proxmoxLXC,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")

    ../../services/k3s.nix

    ../../modules/nix-core.nix
    ../../modules/sops.nix
    ../../modules/sys.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  proxmoxLXC.privileged = true;
  proxmoxLXC.manageNetwork = true;
  nix.settings.sandbox = false;

  time.timeZone = "Asia/Shanghai";
  networking.hostName = "hanabi";
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".text = "nameserver 192.168.5.1\n";

  # auto clean
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.05";
}
