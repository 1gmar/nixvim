{
  config,
  lib,
  ...
}: {
  options.surround = {
    enable = lib.mkEnableOption "enable surround module";
  };
  config = lib.mkIf config.surround.enable {
    plugins.mini.modules.surround = {};
  };
}
