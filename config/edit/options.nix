{ config, lib, ... }:
{
  options.edit.options = {
    enable = lib.mkEnableOption "enable indent options module";
  };
  config = lib.mkIf config.edit.options.enable {
    opts = {
      breakindent = true;
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      softtabstop = 2;
      tabstop = 2;
    };
  };
}
