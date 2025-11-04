{
  config,
  lib,
  ...
}:
{
  options.indent = {
    enable = lib.mkEnableOption "enable indent module";
  };
  config = lib.mkIf config.indent.enable {
    plugins.mini-indentscope = {
      enable = true;
      settings.draw = {
        delay = 0;
        animation.__raw = "function() return 0 end";
      };
    };
  };
}
