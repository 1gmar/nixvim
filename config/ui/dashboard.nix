{ config, lib, ... }:
{
  options.ui.dashboard = {
    enable = lib.mkEnableOption "enable dashboard module";
  };
  config = lib.mkIf config.ui.dashboard.enable {
    plugins.alpha = {
      enable = true;
      theme = "dashboard";
    };
  };
}
