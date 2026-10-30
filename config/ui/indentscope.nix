{ config, lib, ... }:
{
  options.ui.indentscope = {
    enable = lib.mkEnableOption "enable indentscope module";
  };
  config = lib.mkIf config.ui.indentscope.enable {
    plugins.mini-indentscope = {
      enable = true;
      settings = {
        draw = {
          delay = 0;
          animation.__raw = "function() return 0 end";
        };
        symbol = "│";
      };
    };
  };
}
