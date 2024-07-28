{pkgs, ...}: {
  home.shellAliases = {
    k = "kubectl";
    rg = "joshuto";
    lg = "lazygit";
    cd = "z";

    update = "cd ~/flakes && just";
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtraFirst = ''
        if [[ $(uname -s) == "Darwin" ]]; then
            export PATH="$PATH:/opt/homebrew/bin"
        fi
      '';
      oh-my-zsh = {
        enable = true;
        theme = "dstufft";
        plugins = ["git"];
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
