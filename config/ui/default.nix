{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ui = {
    enable = lib.mkEnableOption "enable ui module";
  };
  config = lib.mkIf config.ui.enable {
    colorscheme = lib.mkDefault "solarized-flat";
    extraPlugins = with pkgs.vimPlugins; [nvim-solarized-lua];
    plugins = {
      alpha = {
        enable = true;
        theme = "dashboard";
      };
      lualine = {
        enable = true;
        settings.options.theme = "solarized_light";
      };
      web-devicons.enable = true;
    };
  };
}
