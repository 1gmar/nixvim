{ config, lib, ... }:
{
  options.browser = {
    enable = lib.mkEnableOption "enable git browser module";
  };
  config = lib.mkIf (config.browser.enable && config.telescope.enable) {
    extraFiles = {
      "lua/git-previewers.lua".source = ./git-previewers.lua;
    };
    plugins.telescope = {
      keymaps = {
        "<leader>vl" = {
          action = "git_bcommits";
          mode = "n";
          options = {
            desc = "[v]ersion control [l]ocal history";
          };
        };
        "<leader>vb" = {
          action = "git_branches";
          mode = "n";
          options = {
            desc = "[v]ersion control [b]ranches";
          };
        };
        "<leader>vh" = {
          action = "git_commits";
          mode = "n";
          options = {
            desc = "[v]ersion control [h]istory";
          };
        };
        "<leader>vs" = {
          action = "git_status";
          mode = "n";
          options = {
            desc = "[v]ersion control [s]tatus";
          };
        };
      };
      settings.pickers = {
        git_bcommits = {
          initial_mode = "normal";
          previewer = [
            { __raw = "require('git-previewers').term_git_local_diff_to_parent_previewer"; }
            { __raw = "require('git-previewers').term_git_commit_message_previewer"; }
          ];
          layout_config = {
            height = 0.95;
            preview_width = 0.75;
            prompt_position = "bottom";
            width = 0.95;
          };
          layout_strategy = "horizontal";
          mappings = {
            n = {
              "<A-.>" = "cycle_previewers_next";
              "<A-,>" = "cycle_previewers_prev";
            };
          };
        };
        git_commits = {
          initial_mode = "normal";
          previewer = [
            { __raw = "require('git-previewers').term_git_diff_to_parent_previewer"; }
            { __raw = "require('git-previewers').term_git_commit_message_previewer"; }
          ];
          layout_config = {
            height = 0.95;
            preview_width = 0.75;
            prompt_position = "bottom";
            width = 0.95;
          };
          layout_strategy = "horizontal";
          mappings = {
            n = {
              "<A-.>" = "cycle_previewers_next";
              "<A-,>" = "cycle_previewers_prev";
            };
          };
        };
        git_branches = {
          initial_mode = "normal";
          mappings = {
            n = {
              "<C-d>" = "preview_scrolling_down";
              "<C-u>" = "preview_scrolling_up";
              "<A-d>" = "git_delete_branch";
            };
          };
        };
        git_status = {
          initial_mode = "normal";
          path_display = [ "tail" ];
          previewer.__raw = "require('git-previewers').term_git_status_previewer";
          layout_config = {
            height = 0.95;
            preview_width = 0.75;
            prompt_position = "bottom";
            width = 0.95;
          };
          layout_strategy = "horizontal";
        };
      };
    };
  };
}
