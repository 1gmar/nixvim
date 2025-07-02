{
  config,
  lib,
  ...
}: {
  options.mini-notify = {
    enable = lib.mkEnableOption "enable mini-notify module";
  };
  config = lib.mkIf config.mini-notify.enable {
    plugins.mini.modules.notify = {};
  };
}
