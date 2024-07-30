{lib, ...}: {
  options = {
    # region & system
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

    # k3s & network
    isagent = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    k3sInternIP = lib.mkOption {
      default = "100.99.0.1";
      type = lib.types.str;
    };
  };
}
