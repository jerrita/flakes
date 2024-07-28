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
    ]
    ++ (
      if ismac
      then []
      else [
        psmisc
        sysstat
        iotop
        vim
      ]
    );
}
