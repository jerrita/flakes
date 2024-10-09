{pkgs, ...}: {
  # https://daiderd.com/nix-darwin/manual/index.html

  environment.systemPackages = with pkgs; [
    mas
    skhd
    darwin.iproute2mac
    nixos-rebuild
    wireguard-tools
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
      "pdm"
      "rustup"

      "asitop"
      "openjdk@21"
      "openjdk@17"
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
      "typora"
      "iterm2"
      "lens"
      "pycharm"
      "rustrover"
      "zed"

      # Research
      "zotero"
      "notion"

      # Drive
      "synology-drive"

      # IM
      "telegram"
      "zoom"

      # Utils
      "maczip"
      "appcleaner"
      "iina"
      "stats"
      "raycast"
      "scroll-reverser"
      "microsoft-remote-desktop"
      "balenaetcher"

      # Misc & Game
      "sf-symbols"
      "parsec"
      "background-music"
      "whisky"
      "playcover-community@beta"
      "steam"
      "prismlauncher"
    ];
  };
}
