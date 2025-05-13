{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./completion
    ./lsp
  ];

  completion.enable = lib.mkDefault true;
  lsp.enable = lib.mkDefault true;

  # TODO extract to modules
  autoCmd = [
    {
      command = "lua vim.lsp.buf.format()";
      event = ["BufWritePre"];
      pattern = ["*.nix"];
    }
  ];
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  colorscheme = lib.mkDefault "solarized-flat";
  keymaps = [
    {
      action = ":m .+1<CR>==";
      key = "<A-j>";
      mode = "n";
    }
    {
      action = "<Esc>:m .+1<CR>==gi";
      key = "<A-j>";
      mode = "i";
    }
    {
      action = ":m '>+1<CR>gv=gv";
      key = "<A-j>";
      mode = "v";
    }
    {
      action = ":m .-2<CR>==";
      key = "<A-k>";
      mode = "n";
    }
    {
      action = "<Esc>:m .-2<CR>==gi";
      key = "<A-k>";
      mode = "i";
    }
    {
      action = ":m '<-2<CR>gv=gv";
      key = "<A-k>";
      mode = "v";
    }
    {
      action = "<C-\\><C-n>";
      key = "<Esc>";
      mode = "t";
    }
    {
      action = "<cmd>Neotree reveal toggle<CR>";
      key = "<leader>n";
      mode = "n";
    }
    {
      action = "<cmd>Neotree buffers reveal toggle<CR>";
      key = "<leader>bn";
      mode = "n";
    }
    {
      action = "<cmd>Neotree git_status reveal toggle<CR>";
      key = "<leader>gn";
      mode = "n";
    }
  ];
  opts = {
    background = "light";
    expandtab = true;
    foldlevel = 99;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    smartindent = true;
    softtabstop = 2;
    tabstop = 2;
  };
  extraConfigLuaPost = ''
  '';
  extraConfigVim = ''
  '';
  extraPackages = with pkgs; [alejandra];
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
