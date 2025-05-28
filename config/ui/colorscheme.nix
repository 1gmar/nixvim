{
  config,
  lib,
  pkgs,
  ...
}: {
  options.color-scheme = {
    enable = lib.mkEnableOption "enable color-scheme module";
  };
  config = lib.mkIf config.color-scheme.enable {
    colorscheme = lib.mkDefault "solarized-flat";
    extraPlugins = with pkgs.vimPlugins; [nvim-solarized-lua];
  };
}
