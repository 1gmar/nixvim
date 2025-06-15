{
  config,
  lib,
  ...
}: {
  options.delimiters = {
    enable = lib.mkEnableOption "enable delimiters module";
  };
  config = lib.mkIf config.delimiters.enable {
    extraConfigLuaPost = ''
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", {fg = "#dc322f"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", {fg = "#b58900"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", {fg = "#268bd2"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", {fg = "#cb4b16"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", {fg = "#859900"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", {fg = "#6c71c4"})
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", {fg = "#2aa198"})
    '';
    plugins.rainbow-delimiters.enable = true;
  };
}
