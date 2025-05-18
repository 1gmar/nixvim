{
  config,
  lib,
  ...
}: {
  imports = [
    ./autopairs.nix
    ./selection.nix
  ];
  options.text-editing = {
    enable = lib.mkEnableOption "enable text-editing module";
  };
  config = lib.mkIf config.text-editing.enable {
    autopairs.enable = lib.mkDefault true;
    selection.enable = lib.mkDefault true;
  };
}
