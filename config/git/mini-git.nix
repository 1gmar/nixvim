{
  config,
  lib,
  ...
}: let
  optColorArg =
    if config.ansi-coloring.enable
    then "--color-by-age"
    else "";
  optColorCmd =
    if config.ansi-coloring.enable
    then "vim.cmd('AnsiColorize')"
    else "";
in {
  options.mini-git = {
    enable = lib.mkEnableOption "enable mini-git module";
  };
  config = lib.mkIf config.mini-git.enable {
    autoCmd = [
      {
        callback.__raw = "require('git-blame').git_blame_align";
        event = "User";
        pattern = ["MiniGitCommandSplit"];
      }
      {
        callback.__raw = "require('git-blame').git_blame_trim";
        event = "User";
        pattern = ["MiniGitCommandSplit"];
      }
    ];
    extraFiles = {
      "lua/git-blame.lua".source = ./git-blame.lua;
    };
    keymaps = [
      {
        action.__raw = "require('git-blame').git_blame_toggle";
        key = "<leader>gb";
        mode = ["n"];
      }
      {
        action = "<cmd>lua MiniGit.show_at_cursor()<cr>";
        key = "<leader>gs";
        mode = ["n" "x"];
      }
    ];
    plugins.mini.modules.git = {};
    userCommands."MiniGitBlame" = {
      bang = true;
      command = "lua vim.cmd('vert lefta Git blame --date=human --show-name ${optColorArg} -- %'); vim.cmd(':vert res 50'); ${optColorCmd}";
    };
  };
}
