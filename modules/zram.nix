{...}: {
  boot.kernel.sysctl = {
    "vm.swapiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;

    "vm.vfs_cache_pressure" = 10;
    "vm.dirty_ratio" = 50;

    "net.core.rps_sock_flow_entries" = 32768;
    "net.core.dev_weight" = 600;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };
}
