{pkgs, ...}: {
  # https://daiderd.com/nix-darwin/manual/index.html

  environment.systemPackages = with pkgs; [
    mas
    skhd
    darwin.iproute2mac
    nixos-rebuild
    cargo
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "terraform"
    ];

    masApps = {
      Wechat = 836500024;
      QQ = 451108668;
      Bitwarden = 1352778147;
      TecentMetting = 1484048379;
      Tampermonkey = 1482490089;
    };

    casks = [
      # Dev
      "microsoft-edge"
      "visual-studio-code"
      "obsidian"
      "mark-text"
      "iterm2"
      "lens"

      # Research
      "zotero"

      # Drive
      "synology-drive"

      # IM
      "telegram"

      # Utils
      "appcleaner"
      "iina"
      "stats"
      "raycast"
      "scroll-reverser"
      "microsoft-remote-desktop"

      # Misc
      "clash-verge-rev"
      "whisky"
      "playcover-community@beta"
      "steam"
    ];
  };
}
