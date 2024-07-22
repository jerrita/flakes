{
  pkgs,
  nixpkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    home-manager
    neofetch
    cachix

    # archives
    zip
    xz
    unzip

    # network
    mtr
    iperf3
    dnsutils
    aria2
    socat
    nmap
    nload

    # utils
    ripgrep
    ranger
    lazygit
    jq
    yq-go
    fzf

    # misc
    htop
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # productivity
    glow
    gh
    just
  ];

  programs = {
    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
