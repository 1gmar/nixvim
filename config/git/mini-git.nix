{
  config,
  lib,
  pkgs,
  ...
}:
let
  isAnsiDiff = config.mini-git.enableExtDiff && config.ansi-coloring.enable;
  isAnsiEnabledStr = lib.boolToString config.ansi-coloring.enable;
  miniGitWrapper = pkgs.writers.makeScriptWriter {
    interpreter = "${lib.getExe pkgs.neovim} -l";
  } "/bin/mini-git-wrapper" (builtins.readFile ./mini-git-wrapper.lua);
  mgWrapperExe = lib.getExe miniGitWrapper;
in
{
  options.mini-git = {
    enable = lib.mkEnableOption "enable mini-git module";
    enableExtDiff = lib.mkEnableOption "enable mini-git external diff tool integration";
  };
  config = lib.mkIf config.mini-git.enable {
    autoCmd = [
      {
        callback.__raw = "require('mini-git-utils').on_blame";
        event = "User";
        pattern = [ "MiniGitCommandSplit" ];
      }
      (lib.mkIf isAnsiDiff {
        callback.__raw = "require('mini-git-utils').on_diff";
        event = "User";
        pattern = [ "MiniGitCommandSplit" ];
      })
    ];
    extraFiles = {
      "lua/mini-git-utils.lua".source = ./mini-git-utils.lua;
    };
    keymaps = [
      {
        action.__raw = "require('mini-git-utils').git_blame_toggle(${isAnsiEnabledStr})";
        key = "<leader>gb";
        mode = [ "n" ];
        options.desc = "[g]it [b]lame";
      }
      {
        action.__raw = "require('mini-git-utils').show_at_cursor(${lib.boolToString isAnsiDiff})";
        key = "<leader>vc";
        mode = [
          "n"
          "x"
        ];
        options.desc = "[v]ersion control show at [c]ursor";
      }
    ];
    plugins.mini-git = {
      enable = true;
      settings.job.git_executable = lib.mkIf config.mini-git.enableExtDiff "${mgWrapperExe}";
    };
  };
}
