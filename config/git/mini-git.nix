{
  config,
  lib,
  ...
}: {
  options.mini-git = {
    enable = lib.mkEnableOption "enable mini-git module";
  };
  config = lib.mkIf config.mini-git.enable {
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
