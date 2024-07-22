{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "jerrita";
    userEmail = "je5r1ta@icloud.com";
  };
}
