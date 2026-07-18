{
  colors,
  config,
  lib,
  ...
}:
{
  options.mini-diff = {
    enable = lib.mkEnableOption "enable mini-diff module";
  };
  config = lib.mkIf config.mini-diff.enable {
    highlightOverride = with colors; {
      MiniDiffSignAdd = {
        fg = green;
        ctermfg.__raw = "2";
      };
      MiniDiffSignChange = {
        fg = yellow;
        ctermfg.__raw = "3";
      };
      MiniDiffSignDelete = {
        fg = magenta;
        ctermfg.__raw = "5";
      };
    };
    keymaps = [
      {
        action = "<cmd>lua MiniDiff.toggle_overlay()<cr>";
        key = "<leader>md";
        mode = "n";
      }
    ];
    plugins.mini-diff = {
      enable = true;
      settings.view = {
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
