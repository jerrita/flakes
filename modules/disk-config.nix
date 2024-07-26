{lib, ...}: {
  disko = {
    enableConfig = false;
    devices = {
      disk.main = {
        imageSize = "1500M";
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              priority = 0;
            };
            ESP = {
              type = "EF00";
              size = "512M";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/boot" = {
    device = "/dev/vda1";
    fsType = "vfat";
  };
  fileSystems."/" = {
    device = "/dev/vda2";
    fsType = "ext4";
  };
}
