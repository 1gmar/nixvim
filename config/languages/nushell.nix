{
  config,
  lib,
  pkgs,
  topiary,
  tsGrmrPkgs,
  ...
}:
{
  options.nushell = with lib; {
    enable = mkEnableOption "enable nushell module";
    vimshell = mkOption {
      type =
        with types;
        submodule {
          options = {
            enable = mkEnableOption "enable nushell for vim";
            config = mkOption {
              type = path;
            };
            shell = mkOption {
              type = path;
            };
          };
        };
      default = { };
    };
  };
  config =
    with topiary.lib;
    let
      topiaryNushell = pkgs.fetchFromGitHub {
        owner = "blindFS";
        repo = "topiary-nushell";
        rev = "6e2f9b339a664a46e4015fa5d79e537807fefa39";
        hash = "sha256-fTfxSnVI7TY6vQhD+GimPBRJ4K0SyyVtoLcLGH3xIPc=";
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
          update = old: old // { nixHash = "sha256-G+XuQSqvJ9xRNq4fYiyHK9+AmCNofayPOC6JrFXpcjU="; };
        }
      ] topiaryConfig;
      topiaryWrapper = wrapWithConfig {
        package = topiary.topiary-cli;
        config = prefetchLanguages topiaryConfigWithHash;
      };
    in
    lib.mkIf config.nushell.enable {
      env.TOPIARY_LANGUAGE_DIR = "${topiaryNushell}/queries";
      lsp = {
        fmtOnSaveExts = [ "nu" ];
        servers.nushell = {
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
      };
      opts = lib.mkIf config.nushell.vimshell.enable {
        shell = "${config.nushell.vimshell.shell}";
        shellcmdflag = "--stdin --no-newline --config ${config.nushell.vimshell.config} -c";
        shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record";
        shellredir = "out+err> %s";
        shelltemp = false;
        shellquote = "";
        shellxescape = "";
        shellxquote = "";
      };
      plugins = {
        none-ls = {
          luaConfig.post = ''
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
