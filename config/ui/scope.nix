{ config, lib, ... }:
{
  options.scope = {
    enable = lib.mkEnableOption "enable scope module";
  };
  config = lib.mkIf config.scope.enable {
    plugins.mini-indentscope = {
      enable = true;
      settings.draw = {
        delay = 0;
        animation.__raw = "function() return 0 end";
      };
    };
  };
}
