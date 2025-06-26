{
  config,
  lib,
  ...
}: {
  options.file-finder = {
    enable = lib.mkEnableOption "enable file-finder module";
  };
  config = lib.mkIf config.file-finder.enable {
    plugins.telescope = {
      enable = true;
      extensions = {
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
