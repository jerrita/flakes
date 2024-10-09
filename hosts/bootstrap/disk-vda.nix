{...}: {
  fileSystems."/boot" = {
    device = "/dev/vda2";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/vda3";
    fsType = "ext4";
  };
}
