{
  config,
  lib,
  ...
}: {
  options.icons = {
    enable = lib.mkEnableOption "enable icons module";
  };
  config = lib.mkIf config.icons.enable {
    plugins.web-devicons.enable = true;
  };
}
