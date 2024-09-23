{...}: {
  fileSystems."/boot" = {
    device = "/dev/sda2";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
  };
}