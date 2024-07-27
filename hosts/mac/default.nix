{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./host.nix
    ./apps.nix

    ./sketchybar
    ./yabai.nix
    ./skhd.nix

    ../../modules/nix-core.nix
    ../../modules/homebrew-mirror.nix
    ../../modules/fonts.nix
    ../../modules/user.nix
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
      NSGlobalDomain._HIHideMenuBar = true;
      screencapture.location = "~/Screenshots";
      trackpad.Clicking = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  nix.package = pkgs.nix;
  programs.zsh.enable = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
