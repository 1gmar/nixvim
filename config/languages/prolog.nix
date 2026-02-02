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
    lsp = lib.mkOption {
      type =
        with lib.types;
        submodule {
          options = {
            enable = lib.mkEnableOption "enable prolog lsp";
            cmd = lib.mkOption {
              type = listOf str;
              default = [
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
            };
          };
        };
      default = { };
    };
  };
  config = lib.mkIf config.prolog.enable {
    extraPackages = lib.mkIf config.prolog.lsp.enable [ pkgs.swi-prolog ];
    filetype.extension = {
      pl = "prolog";
    };
    lsp = lib.mkIf config.prolog.lsp.enable {
      fmtOnSaveExts = [ "pl" ];
      servers.prolog_ls = {
        inherit (config.prolog.lsp) enable;
        name = "prolog_ls";
        package = null;
        settings = {
          inherit (config.prolog.lsp) cmd;
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
