{ config, lib, ... }:
{
  options.search-options = {
    enable = lib.mkEnableOption "enable search options module";
  };
  config = lib.mkIf config.search-options.enable {
    opts = {
      ignorecase = true;
      smartcase = true;
    };
  };
}
