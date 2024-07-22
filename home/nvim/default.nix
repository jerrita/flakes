{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # plugins = let
    #   nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins:
    #     with treesitter-plugins; [
    #       bash
    #       c
    #       cpp
    #       lua
    #       nix
    #       python
    #       rust
    #       markdown
    #     ]);
    # in
    #   with pkgs.vimPlugins; [
    #     lazy-nvim

    #     # theme
    #     tokyonight-nvim

    #     # utils
    #     lazygit-nvim
    #     flash-nvim
    #     project-nvim
    #     telescope-nvim
    #     # cinnamon-nvim # scroll animation
    #     which-key-nvim

    #     # window
    #     barbecue-nvim
    #     bufferline-nvim
    #     dashboard-nvim
    #     vim-tmux-navigator
    #     lualine-nvim
    #     neo-tree-nvim

    #     # lsp
    #     auto-pairs
    #     comment-nvim
    #     outline-nvim
    #     lsp_signature-nvim
    #     crates-nvim
    #     mason-nvim
    #     mason-lspconfig-nvim
    #     lspsaga-nvim
    #     nvim-cmp
    #     nvim-lspconfig
    #     nvim-treesitter-with-plugins
    #   ];
  };
}
