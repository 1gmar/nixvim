{ config, lib, ... }:
{
  options.edit.autopairs = {
    enable = lib.mkEnableOption "enable autopairs module";
  };
  config = lib.mkIf config.edit.autopairs.enable {
    plugins.mini-pairs.enable = true;
  };
}
