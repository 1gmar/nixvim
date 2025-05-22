{
  config,
  lib,
  ...
}: {
  imports = [
    ./autopairs.nix
    ./comment.nix
    ./selection.nix
    ./surround.nix
  ];
  options.text-editing = {
    enable = lib.mkEnableOption "enable text-editing module";
  };
  config = lib.mkIf config.text-editing.enable {
    autopairs.enable = lib.mkDefault true;
    comment.enable = lib.mkDefault true;
    selection.enable = lib.mkDefault true;
    surround.enable = lib.mkDefault true;
  };
}
