{
  config,
  lib,
  pkgs,
  system,
  tsGrmrPkgs,
  ...
}:
{
  options.nix = {
    enable = lib.mkEnableOption "enable nix module";
  };
  config = lib.mkIf config.nix.enable {
    autoCmd = [
      {
        command = "inoremap <buffer> <C-'> '''';<Esc>3ha";
        event = [ "FileType" ];
        pattern = [ "nix" ];
      }
    ];
    lsp.fmtOnSaveExts = [ "nix" ];
    extraPackages = [ pkgs.nixfmt ];
    lsp.servers.nixd = {
      enable = true;
      config = {
        cmd = [ "nixd" ];
        filetypes = [ "nix" ];
        root_markers = [
          ".git"
          "flake.nix"
        ];
        settings.nixd = {
          formatting.command = lib.mkDefault [ "nixfmt" ];
          nixpkgs.expr = lib.mkDefault "import <nixpkgs> { }";
          options.nixvim.expr = ''(builtins.getFlake "github:1gmar/nixvim").packages.${system}.default.options'';
        };
      };
    };
    plugins = {
      none-ls.sources = {
        code_actions = {
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
        };
      };
      treesitter.grammarPackages = [ tsGrmrPkgs.nix ];
    };
  };
}
