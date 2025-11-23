{ config, lib, ... }:
{
  imports = [
    ./common
    ./java

    ./lua.nix
    ./nix.nix
    ./nushell.nix
  ];
  options.languages = {
    enable = lib.mkEnableOption "enable languages module";
  };
  config = lib.mkIf config.languages.enable {
    common.enable = lib.mkDefault true;
    java.enable = lib.mkDefault false;
    lua.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    nushell.enable = lib.mkDefault false;
  };
}
