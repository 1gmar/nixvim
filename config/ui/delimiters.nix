{
  config,
  lib,
  ...
}: {
  options.delimiters = {
    enable = lib.mkEnableOption "enable delimiters module";
  };
  config = lib.mkIf config.delimiters.enable {
    highlightOverride = {
      RainbowDelimiterRed = {fg = "#dc322f";};
      RainbowDelimiterYellow = {fg = "#b58900";};
      RainbowDelimiterBlue = {fg = "#268bd2";};
      RainbowDelimiterOrange = {fg = "#cb4b16";};
      RainbowDelimiterGreen = {fg = "#859900";};
      RainbowDelimiterViolet = {fg = "#6c71c4";};
      RainbowDelimiterCyan = {fg = "#2aa198";};
    };
    plugins.rainbow-delimiters.enable = true;
  };
}
