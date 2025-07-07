{
  config,
  lib,
  ...
}: {
  options.mini-diff = {
    enable = lib.mkEnableOption "enable mini-diff module";
  };
  config = lib.mkIf config.mini-diff.enable {
    highlightOverride = {
      MiniDiffSignAdd = {fg = "#859900";};
      MiniDiffSignChange = {fg = "#b58900";};
      MiniDiffSignDelete = {fg = "#d33682";};
    };
    keymaps = [
      {
        action = "<cmd>lua MiniDiff.toggle_overlay()<cr>";
        key = "<leader>md";
        mode = "n";
      }
    ];
    plugins.mini.modules.diff = {
      view = {
        style = "sign";
        signs = {
          add = "▌";
          change = "▌";
          delete = "▌";
        };
      };
    };
  };
}
