{
  config,
  lib,
  ...
}: {
  options.selection = {
    enable = lib.mkEnableOption "enable selection module";
  };
  config = lib.mkIf config.selection.enable {
    plugins.mini.modules.ai = {};
  };
}
