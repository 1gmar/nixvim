{
  config,
  lib,
  ...
}: {
  options.autopairs = {
    enable = lib.mkEnableOption "enable autopairs module";
  };
  config = lib.mkIf config.autopairs.enable {
    plugins.mini.modules.pairs = {};
  };
}
