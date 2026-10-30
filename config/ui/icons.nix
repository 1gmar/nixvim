{ config, lib, ... }:
{
  options.ui.icons = {
    enable = lib.mkEnableOption "enable icons module";
  };
  config = lib.mkIf config.ui.icons.enable {
    plugins.web-devicons = {
      enable = true;
    };
  };
}
