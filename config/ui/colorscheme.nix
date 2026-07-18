{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.color-scheme = {
    enable = lib.mkEnableOption "enable color-scheme module";
  };
  config = lib.mkIf config.color-scheme.enable {
    colorscheme = lib.mkDefault "solarized8";
    extraPlugins = with pkgs.vimPlugins; [ vim-solarized8 ];
  };
}
