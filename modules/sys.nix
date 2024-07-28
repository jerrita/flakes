{
  pkgs,
  ismac,
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
      if ismac
      then []
      else [
        psmisc
        sysstat
        inetutils
        iotop
        vim
        screenfetch
      ]
    );
}
