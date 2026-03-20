{ config, lib, ... }:
{
  imports = [
    ./options.nix
    ./telescope.nix
  ];
  options.search = {
    enable = lib.mkEnableOption "enable search module";
  };
  config = lib.mkIf config.search.enable {
    search-options.enable = lib.mkDefault true;
    telescope.enable = lib.mkDefault true;
  };
}
