{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
      };

      autocomplete.blink-cmp.enable = true;
      statusline.lualine.enable = true;
      filetree.neo-tree.enable = true;
      ui.noice.enable = true;

      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options = {
          numbers = "ordinal";
          separator_style = "thick";
        };
      };

      diagnostics = {
        enable = true;
        config = {
          signs = true;
          underline = true;
          virtual_text = true;
          update_in_insert = true;
        };
      };

      lazy.plugins."nightfox.nvim" = {
        package = pkgs.vimPlugins.nightfox-nvim;
        after = ''vim.cmd("colorscheme carbonfox")'';
      };

      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        ts.enable = true;
        go.enable = true;
        nix.enable = true;
        clang.enable = true;
        python.enable = true;
      };
    };
  };
}
