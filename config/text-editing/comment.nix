{
  config,
  lib,
  ...
}: {
  options.comment = {
    enable = lib.mkEnableOption "enable comment module";
  };
  config = lib.mkIf config.comment.enable {
    plugins.mini.modules.comment = {};
  };
}
