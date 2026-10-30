{ config, lib, ... }:
{
  imports = [
    ./autopairs.nix
    ./comment.nix
    ./find-and-replace.nix
    ./options.nix
    ./selection.nix
    ./surround.nix
  ];
  options.edit = {
    enable = lib.mkEnableOption "enable edit module";
  };
  config.edit = lib.mkIf config.edit.enable {
    autopairs.enable = lib.mkDefault true;
    comment.enable = lib.mkDefault true;
    find-and-replace.enable = lib.mkDefault true;
    options.enable = lib.mkDefault true;
    selection.enable = lib.mkDefault true;
    surround.enable = lib.mkDefault true;
  };
}
