{
  config,
  lib,
  ...
}: {
  options.dashboard = {
    enable = lib.mkEnableOption "enable dashboard module";
  };
  config = lib.mkIf config.dashboard.enable {
    plugins.alpha = {
      enable = true;
      theme = "dashboard";
    };
  };
}
