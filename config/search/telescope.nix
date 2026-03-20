{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.telescope = {
    enable = lib.mkEnableOption "enable telescope module";
  };
  config = lib.mkIf config.telescope.enable {
    extraPackages = with pkgs; [ ripgrep ];
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          enable = true;
          settings = {
            case_mode = "smart_case";
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
          };
        };
        undo.enable = true;
        ui-select = {
          enable = true;
          settings = {
            __raw = "{ require('telescope.themes').get_dropdown {} }";
          };
        };
      };
      keymaps = {
        "<leader>ch" = {
          action = "command_history";
          mode = "n";
          options.desc = "[c]ommand [h]istory";
        };
        "<leader>cl" = {
          action = "commands";
          mode = "n";
          options.desc = "[c]ommand [l]ist";
        };
        "<leader>ff" = {
          action = "find_files";
          mode = "n";
          options.desc = "[f]ind [f]iles";
        };
        "<leader>fg" = {
          action = "live_grep";
          mode = "n";
          options.desc = "[f]ind using [g]rep";
        };
        "<leader>fb" = {
          action = "buffers";
          mode = "n";
          options.desc = "[f]ind current [b]uffers";
        };
        "<leader>fh" = {
          action = "help_tags";
          mode = "n";
          options.desc = "[f]ind [h]elp tags";
        };
        "<leader>fd" = {
          action = "diagnostics";
          mode = "n";
          options.desc = "[f]ind [d]iagnostics";
        };
        "<leader>fr" = {
          action = "oldfiles cwd_only=true";
          mode = "n";
          options.desc = "[f]ind [r]ecent files";
        };
        "<leader>fk" = {
          action = "keymaps";
          mode = "n";
          options.desc = "[f]ind [k]eymaps";
        };
        "<leader>fs" = {
          action = "treesitter";
          mode = "n";
          options.desc = "[f]ind treesitter [s]ymbols";
        };
        "<leader>sh" = {
          action = "search_history";
          mode = "n";
          options.desc = "[s]earch [h]istory";
        };
      };
      settings = {
        defaults = {
          prompt_prefix = "  ";
          selection_caret = " ";
          dynamic_preview_title = true;
        };
        pickers = {
          buffers = {
            initial_mode = "normal";
            previewer = false;
            theme = "dropdown";
          };
          command_history = {
            theme = "dropdown";
          };
          diagnostics = {
            initial_mode = "normal";
            previewer = false;
            theme = "dropdown";
          };
          find_files = {
            previewer = false;
            theme = "dropdown";
          };
          oldfiles = {
            previewer = false;
            theme = "dropdown";
          };
          planets = {
            show_moon = true;
            show_pluto = true;
            theme = "ivy";
          };
          search_history = {
            theme = "dropdown";
          };
          treesitter = {
            theme = "ivy";
          };
        };
      };
    };
  };
}
