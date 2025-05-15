{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./commons
    ./completion
    ./keymappings
    ./lsp
  ];

  commons.enable = lib.mkDefault true;
  completion.enable = lib.mkDefault true;
  keymappings.enable = lib.mkDefault true;
  lsp.enable = lib.mkDefault true;

  # TODO extract to modules
  colorscheme = lib.mkDefault "solarized-flat";
  extraPlugins = with pkgs.vimPlugins; [nvim-solarized-lua];
  plugins = {
    alpha = {
      enable = true;
      theme = "dashboard";
    };
    lualine = {
      enable = true;
      settings.options.theme = "solarized_light";
    };
    neo-tree = {
      enable = true;
      popupBorderStyle = "rounded";
      window.position = "right";
    };
    none-ls = {
      enable = true;
      sources = {
        code_actions = {
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
        };
      };
    };
    telescope = {
      enable = true;
      extensions = {
        live-grep-args.enable = true;
        ui-select.enable = true;
      };
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          mode = "n";
        };
        "<leader>fg" = {
          action = "live_grep";
          mode = "n";
        };
        "<leader>fb" = {
          action = "buffers";
          mode = "n";
        };
        "<leader>fh" = {
          action = "help_tags";
          mode = "n";
        };
      };
    };
    treesitter = {
      enable = true;
      folding = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<CR>";
            node_decremental = "<C-j>";
            node_incremental = "<C-k>";
            scope_incremental = "<C-h>";
          };
        };
      };
    };
    web-devicons.enable = true;
  };
}
