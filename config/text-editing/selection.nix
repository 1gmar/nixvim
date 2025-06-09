{
  config,
  lib,
  ...
}: {
  options.selection = {
    enable = lib.mkEnableOption "enable selection module";
  };
  config = lib.mkIf config.selection.enable {
    plugins.mini.modules.ai = {
      search_method = "cover_or_next";
    };
  };
}
