{
  username,
  pkgs,
  ismac ? false,
  ...
}: {
  users.users."${username}" =
    if ismac
    then {
      home = "/Users/${username}";
    }
    else {
      isNormalUser = true;
      # home = "/home/${username}";
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINu+Alullj1Meq+a3KNFlIT9lU9YCb8WDr/mZhHCEPji jerrita@mac-air"
      ];
    };

  nix.settings.trusted-users = [username];
}
