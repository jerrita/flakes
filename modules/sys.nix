{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      htop
      curl
      wget
      git
      alejandra
      neofetch

      tldr
    ]
    ++ (
      if config.ismac
      then []
      else [
        psmisc
        lsof
        sysstat
        inetutils
        iotop
        vim
        screenfetch
      ]
    );
}
