{
  config,
  lib,
  pkgs,
  tsGrmrPkgs,
  ...
}:
{
  options.prolog = {
    enable = lib.mkEnableOption "enable prolog module";
    enableLsp = lib.mkEnableOption "enable prolog lsp";
  };
  config = lib.mkIf config.prolog.enable {
    extraPackages = lib.mkIf config.prolog.enableLsp [ pkgs.swi-prolog ];
    filetype.extension = {
      pl = "prolog";
    };
    lsp = lib.mkIf config.prolog.enableLsp {
      fmtOnSaveExts = [ "pl" ];
      servers.prolog_ls = {
        enable = config.prolog.enableLsp;
        name = "prolog_ls";
        package = null;
        settings = {
          cmd = [
            "swipl"
            "-g"
            "use_module('./packs/lsp_server/prolog/lsp_server.pl')."
            "-g"
            "lsp_server:main"
            "-t"
            "halt"
            "--"
            "stdio"
          ];
          filetypes = [ "prolog" ];
          rootMarkers = [
            "packs.pl"
            ".git"
          ];
        };
      };
    };
    plugins = {
      treesitter.grammarPackages = [ tsGrmrPkgs.prolog ];
      web-devicons.settings = {
        override_by_extension = lib.nixvim.utils.toRawKeys {
          "\"pl\"" = {
            icon = "";
            color = "#725C2A";
            cterm_color = "94";
            name = "Prolog";
          };
        };
        strict = true;
      };
    };
  };
}
