{pkgs, ...}: {
  home.shellAliases = {
    cd = "z";
    k = "kubectl";
    rg = "ranger";
    lg = "lazygit";

    l = "ls -lG";
    ls = "ls -G";
    ll = "ls -lhG";

    update = "cd ~/flakes && just";
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };

  home.packages = [pkgs.zsh-powerlevel10k];
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtraFirst = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

        if [[ $(uname -s) == "Darwin" ]]; then
            export PATH="$PATH:/opt/homebrew/bin"
        fi
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
