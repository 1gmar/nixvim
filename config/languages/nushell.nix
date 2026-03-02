{
  config,
  lib,
  pkgs,
  topiary,
  tsGrmrPkgs,
  ...
}:
{
  options.nushell = {
    enable = lib.mkEnableOption "enable nushell module";
  };
  config =
    with topiary.lib;
    let
      topiaryNushell = pkgs.fetchFromGitHub {
        owner = "blindFS";
        repo = "topiary-nushell";
        rev = "98690f7ce6eadc2dd715eb57519c6ec0d408241e";
        hash = "sha256-iJ6KIqdnae6hSup6d11gv6KCsOzqhD8ZMdQRR3PSCqU=";
      };
      topiaryConfig = fromNickelFile "${topiaryNushell}/languages.ncl";
      topiaryConfigWithHash = lib.updateManyAttrsByPath [
        {
          path = [
            "languages"
            "nu"
            "grammar"
            "source"
            "git"
          ];
          update = old: old // { nixHash = "sha256-0ebKHKexu1TROwfxokwwpPhCO+Nn7HmmX40jRu19xNo="; };
        }
      ] topiaryConfig;
      topiaryWrapper = wrapWithConfig {
        package = topiary.topiary-cli;
        config = prefetchLanguages topiaryConfigWithHash;
      };
    in
    lib.mkIf config.nushell.enable {
      env.TOPIARY_LANGUAGE_DIR = "${topiaryNushell}/queries";
      lsp.fmtOnSaveExts = [ "nu" ];
      lsp.servers.nushell = {
        enable = true;
        config = {
          cmd = [
            "nu"
            "--lsp"
          ];
          filetypes = [ "nu" ];
          root_dir.__raw = ''
            function(bufnr, on_dir)
              on_dir(
                vim.fs.root(bufnr, { '.git' }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
            end
          '';
        };
      };
      plugins = {
        none-ls = {
          luaConfig.post = ''
            local null_ls = require('null-ls')
            null_ls.register({
              name = 'topiary-nushell',
              method = null_ls.methods.FORMATTING,
              filetypes = { 'nu' },
              generator = null_ls.formatter({
                args = { 'format', '--language', 'nu' },
                command = '${lib.getExe topiaryWrapper}',
                to_stdin = true,
              })
            })
          '';
        };
        treesitter.grammarPackages = [ tsGrmrPkgs.nu ];
      };
    };
}
