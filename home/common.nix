{pkgs, ...}: {
  home.packages = with pkgs; [
    home-manager
    neofetch
    cachix

    # sre
    kubectl
    kubernetes-helm
    watch

    # fonts
    jetbrains-mono

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
    sops
    ripgrep
    joshuto
    lazygit
    jq
    yq-go
    fzf
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
    tldr
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
