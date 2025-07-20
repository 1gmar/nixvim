{
  colors,
  config,
  lib,
  ...
}: {
  options.mini-diff = {
    enable = lib.mkEnableOption "enable mini-diff module";
  };
  config = lib.mkIf config.mini-diff.enable {
    highlightOverride = with colors; {
      MiniDiffSignAdd = {fg = green;};
      MiniDiffSignChange = {fg = yellow;};
      MiniDiffSignDelete = {fg = magenta;};
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
