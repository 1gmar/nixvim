{
  config,
  lib,
  tsGrmrPkgs,
  ...
}:
{
  options.nushell = {
    enable = lib.mkEnableOption "enable nushell module";
  };
  config = lib.mkIf config.nushell.enable {
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
    plugins.treesitter.grammarPackages = [ tsGrmrPkgs.nu ];
  };
}
