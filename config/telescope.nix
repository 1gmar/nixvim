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
        live-grep-args.enable = true;
        ui-select = {
          enable = true;
          settings = {
            __raw = "{ require('telescope.themes').get_dropdown {} }";
          };
        };
      };
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          mode = "n";
          options = {
            desc = "[f]ind [f]iles";
          };
        };
        "<leader>fg" = {
          action = "live_grep";
          mode = "n";
          options = {
            desc = "[f]ind using [g]rep";
          };
        };
        "<leader>fb" = {
          action = "buffers";
          mode = "n";
          options = {
            desc = "[f]ind current [b]uffers";
          };
        };
        "<leader>fh" = {
          action = "help_tags";
          mode = "n";
          options = {
            desc = "[f]ind [h]elp tags";
          };
        };
        "<leader>fd" = {
          action = "diagnostics";
          mode = "n";
          options = {
            desc = "[f]ind [d]iagnostics";
          };
        };
        "<leader>fr" = {
          action = "oldfiles cwd_only=true";
          mode = "n";
          options = {
            desc = "[f]ind [r]ecent files";
          };
        };
        "<leader>vs" = {
          action = "git_status";
          mode = "n";
          options = {
            desc = "[v]ersion control [s]tatus";
          };
        };
        "<leader>fk" = {
          action = "keymaps";
          mode = "n";
          options = {
            desc = "[f]ind [k]eymaps";
          };
        };
      };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<S-Enter>" = "select_vertical";
              "<A-Enter>" = "select_horizontal";
            };
          };
          prompt_prefix = "  ";
          selection_caret = " ";
        };
        pickers = {
          buffers = {
            initial_mode = "normal";
            previewer = false;
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
          git_status = {
            initial_mode = "normal";
            theme = "ivy";
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
        };
      };
    };
  };
}
