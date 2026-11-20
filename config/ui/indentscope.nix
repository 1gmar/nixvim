{
  colors,
  config,
  lib,
  ...
}:
{
  options.ui.indentscope = {
    enable = lib.mkEnableOption "enable indentscope module";
  };
  config = lib.mkIf config.ui.indentscope.enable {
    highlightOverride = with colors; {
      MiniIndentscopeSymbol = {
        fg = gui.secondaryContent;
        ctermfg.__raw = cterm.secondaryContent;
        bold = true;
      };
      SnacksIndent = {
        fg = gui.backHighlight;
        ctermfg.__raw = cterm.backHighlight;
        bold = true;
      };
    };
    plugins = {
      snacks = {
        enable = true;
        settings = {
          indent = {
            enabled = true;
            char = "│";
            animate.enabled = false;
            scope.enabled = false;
          };
        };
      };
      mini-indentscope = {
        enable = true;
        settings = {
          draw = {
            delay = 0;
            animation.__raw = "function() return 0 end";
          };
          symbol = "│";
        };
      };
    };
  };
}
