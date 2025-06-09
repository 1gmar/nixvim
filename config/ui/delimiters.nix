{
  config,
  lib,
  ...
}: {
  options.delimiters = {
    enable = lib.mkEnableOption "enable delimiters module";
  };
  config = lib.mkIf config.delimiters.enable {
    plugins.rainbow-delimiters.enable = true;
  };
}
