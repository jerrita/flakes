{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    psmisc
    curl
    wget
    git
    iotop
    sysstat
    alejandra
  ];
}
