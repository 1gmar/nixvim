{ config, lib, ... }:
{
  options.languages.dap = {
    enable = lib.mkEnableOption "enable dap module";
  };
  config = lib.mkIf config.languages.dap.enable {
    plugins.dap = {
      enable = true;
    };
  };
}
