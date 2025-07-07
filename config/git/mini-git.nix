{
  config,
  lib,
  ...
}: {
  options.mini-git = {
    enable = lib.mkEnableOption "enable mini-git module";
  };
  config = lib.mkIf config.mini-git.enable {
    # TODO git blame --date=human config/git/mini-diff.nix | awk '{split($0, L, "("); split(L[1], H, " "); split(L[2], S, ")"); print H[1], S[1]}' | awk 'NF{NF--};1'
    autoCmd = [
      {
        callback.__raw = "require('git-blame').git_blame_align";
        event = "User";
        pattern = ["MiniGitCommandSplit"];
      }
    ];
    extraFiles = {
      "lua/git-blame.lua".source = ./git-blame.lua;
    };
    keymaps = [
      {
        action = "<cmd>lua MiniGit.show_at_cursor()<cr>";
        key = "<leader>gs";
        mode = ["n" "x"];
      }
    ];
    plugins.mini.modules.git = {};
  };
}
