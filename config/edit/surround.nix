{ config, lib, ... }:
{
  options.edit.surround = {
    enable = lib.mkEnableOption "enable surround module";
  };
  config = lib.mkIf config.edit.surround.enable {
    plugins.mini-surround = {
      enable = true;
      settings.custom_surroundings = {
        r = {
          output = {
            left = "\n";
            right = "\n";
          };
        };
      };
    };
  };
}
