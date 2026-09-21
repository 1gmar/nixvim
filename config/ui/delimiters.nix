{
  colors,
  config,
  lib,
  ...
}:
{
  options.delimiters = {
    enable = lib.mkEnableOption "enable delimiters module";
  };
  config = lib.mkIf config.delimiters.enable {
    highlightOverride = with colors; {
      RainbowDelimiterRed = {
        fg = gui.red;
        ctermfg.__raw = toString cterm.red;
      };
      RainbowDelimiterYellow = {
        fg = gui.yellow;
        ctermfg.__raw = toString cterm.yellow;
      };
      RainbowDelimiterBlue = {
        fg = gui.blue;
        ctermfg.__raw = toString cterm.blue;
      };
      RainbowDelimiterOrange = {
        fg = gui.orange;
        ctermfg.__raw = toString cterm.orange;
      };
      RainbowDelimiterGreen = {
        fg = gui.green;
        ctermfg.__raw = toString cterm.green;
      };
      RainbowDelimiterViolet = {
        fg = gui.violet;
        ctermfg.__raw = toString cterm.violet;
      };
      RainbowDelimiterCyan = {
        fg = gui.cyan;
        ctermfg.__raw = toString cterm.cyan;
      };
    };
    plugins.rainbow-delimiters.enable = true;
  };
}
