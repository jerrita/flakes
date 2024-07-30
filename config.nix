{lib, ...}: {
  options = {
    iscn = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    ismac = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    islxc = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    isagent = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };
}
