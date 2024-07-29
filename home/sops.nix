{
  inputs,
  osConfig,
  username,
  ...
}: let
  homedir =
    if osConfig.ismac
    then "/Users/${username}"
    else "/home/${username}";
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];
  sops = {
    # age.keyFile = "${homedir}/.age-key.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    age.sshKeyPaths = ["${homedir}/.ssh/id_ed25519"];
    defaultSopsFile = ../secrets/common/default.yaml;
    secrets.env = {
      # sopsFile = ./secrets.yml.enc; # optionally define per-secret files

      # %r gets replaced with a runtime directory, use %% to specify a '%'
      # sign. Runtime dir is $XDG_RUNTIME_DIR on linux and $(getconf
      # DARWIN_USER_TEMP_DIR) on darwin.
      path = "%r/env";
    };
  };
}
