{
  osConfig,
  unstable,
  ...
}: let
  sops-prefix =
    if osConfig.ismac
    then "$(getconf DARWIN_USER_TEMP_DIR)"
    else "$XDG_RUNTIME_DIR";
in {
  home.shellAliases = {
    lg = "lazygit";
    cd = "z";
    ls = "ls -G";
    ll = "ls -lGh";
    l = "ls -G";
    k = "kubectl";
    wgen = "wg genkey | tee privatekey | wg pubkey > publickey";

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
        source ${sops-prefix}/env
        if [[ $(uname -s) == "Darwin" ]]; then
            export PATH="$PATH:/opt/homebrew/bin"
        fi
      '';
      oh-my-zsh = {
        enable = false;
        theme = "dstufft";
        plugins = ["git" "kubectl"];
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    yazi = {
      enable = true;
      package = unstable.yazi;
      enableZshIntegration = true;
    };
  };
}
