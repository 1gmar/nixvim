{ config, lib, ... }:
{
  options.dap = {
    enable = lib.mkEnableOption "enable dap module";
  };
  config = lib.mkIf config.dap.enable {
    plugins.dap = {
      enable = true;
    };
  };
}
