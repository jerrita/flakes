{
  username,
  ismac ? false,
  ...
}: {
  # import sub modules
  imports = [
    ./shell.nix
    ./common.nix
    ./git.nix
    ./sops.nix
    ./nvim
  ];

  home = {
    username = "${username}";
    homeDirectory =
      if ismac
      then "/Users/${username}"
      else "/home/${username}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
