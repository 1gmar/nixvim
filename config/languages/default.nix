{
  config,
  lib,
  ...
}: {
  imports = [
    ./lsp.nix
    ./lua.nix
    ./nix.nix
    ./none-ls.nix
    ./treesitter.nix
  ];
  options.languages = {
    enable = lib.mkEnableOption "enable languages module";
  };
  config = lib.mkIf config.languages.enable {
    lsp.enable = lib.mkDefault true;
    lua.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    none-ls.enable = lib.mkDefault true;
    treesitter.enable = lib.mkDefault true;
  };
}
