{username, homedir, ...}:
{
  users.users."${username}" = {
    home = "${homedir}";
    description = "Home directory for ${username}";
  };

  nix.settings.trusted-users = [username];
}
