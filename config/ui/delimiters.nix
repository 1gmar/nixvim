{
  colors,
  config,
  lib,
  ...
}: {
  options.delimiters = {
    enable = lib.mkEnableOption "enable delimiters module";
  };
  config = lib.mkIf config.delimiters.enable {
    highlightOverride = with colors; {
      RainbowDelimiterRed = {fg = red;};
      RainbowDelimiterYellow = {fg = yellow;};
      RainbowDelimiterBlue = {fg = blue;};
      RainbowDelimiterOrange = {fg = orange;};
      RainbowDelimiterGreen = {fg = green;};
      RainbowDelimiterViolet = {fg = violet;};
      RainbowDelimiterCyan = {fg = cyan;};
    };
    plugins.rainbow-delimiters.enable = true;
  };
}
