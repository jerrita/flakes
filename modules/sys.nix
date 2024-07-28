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

      inetutils
      tldr
    ]
    ++ (
      if ismac
      then []
      else [
        psmisc
        sysstat
        iotop
        vim
        screenfetch
      ]
    );
}
