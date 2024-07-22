{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./host.nix
    ./apps.nix

    # ./yabai.nix
    # ./skhd.nix

    ../../modules/nix-core.nix
    ../../modules/homebrew-mirror.nix
  ];

  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowStatusBar = true;
      };
      screencapture.location = "~/Screenshots";
      trackpad.Clicking = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
}
