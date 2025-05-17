{
  config,
  lib,
  ...
}: {
  imports = [
    ./lsp.nix
    ./none-ls.nix
    ./treesitter.nix
  ];
  options.languages = {
    enable = lib.mkEnableOption "enable languages module";
  };
  config = lib.mkIf config.languages.enable {
    lsp.enable = lib.mkDefault true;
    none-ls.enable = lib.mkDefault true;
    treesitter.enable = lib.mkDefault true;
  };
}
