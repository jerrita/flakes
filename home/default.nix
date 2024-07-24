{
  username,
  homedir,
  ...
}: {
  # import sub modules
  imports = [
    ./shell.nix
    ./common.nix
    ./git.nix
    ./nvim
  ];

  home = {
    username = "${username}";
    homeDirectory = "${homedir}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
