{
  config,
  lib,
  nufmt,
  pkgs,
  topiary,
  tsGrmrPkgs,
  ...
}:
with topiary.lib;
let
  cfg = config.languages.nushell;
  nufmtConfig = pkgs.writers.writeJSON "nufmt-config.json" {
    indent = 2;
    indent_char = "space";
    line_length = 100;
    margin = 0;
    exclude = [ ];
  };
  fmtConfig = pkgs.runCommandLocal "nufmt-config.nuon" { nativeBuildInputs = [ pkgs.nushell ]; } ''
    nu -n -c 'open ${nufmtConfig} | to nuon -i 2' > $out
  '';
  topiaryNushell = pkgs.fetchFromGitHub {
    owner = "blindFS";
    repo = "topiary-nushell";
    rev = "b187defff76caaea7c95614047c1779a675df0f6";
    hash = "sha256-a9yWF75XPll2EYGE0LEDByFCcLUC+DmgfRToqTUNi60=";
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
      update = old: old // { nixHash = "sha256-eWHAcV8bPCnL9y4PtPn6cJRylGQ2KMxCUoUGwDVigkg="; };
    }
  ] topiaryConfig;
  topiaryWrapper = wrapWithConfig {
    package = topiary.topiary-cli;
    config = prefetchLanguages topiaryConfigWithHash;
  };
  genFormatter =
    {
      name,
      args,
      cmd,
    }:
    ''
      null_ls.register({
        name = '${name}',
        method = null_ls.methods.FORMATTING,
        filetypes = { 'nu' },
        generator = null_ls.formatter({
          args = ${lib.nixvim.lua.toLuaObject args},
          command = '${lib.getExe cmd}',
          to_stdin = true,
        })
      })
    '';
in
{
  options.languages.nushell = with lib; {
    enable = mkEnableOption "enable nushell module";
    nufmt-enable = mkEnableOption "enable nufmt";
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
  config = lib.mkIf cfg.enable {
    env.TOPIARY_LANGUAGE_DIR = "${topiaryNushell}/queries";
    languages.lsp.fmtOnSaveExts = [ "nu" ];
    lsp = {
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
        packageFallback = true;
      };
    };
    opts = lib.mkIf cfg.vimshell.enable {
      shell = "${cfg.vimshell.shell}";
      shellcmdflag = "--stdin --no-newline --config ${cfg.vimshell.config} -c";
      shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record";
      shellredir = "out+err> %s";
      shelltemp = false;
      shellquote = "";
      shellxescape = "";
      shellxquote = "";
    };
    plugins = {
      none-ls = {
        luaConfig.post = genFormatter (
          if cfg.nufmt-enable then
            {
              name = "nufmt";
              args = [
                "--stdin"
                "-c"
                fmtConfig
              ];
              cmd = nufmt;
            }
          else
            {
              name = "topiary-nushell";
              args = [
                "format"
                "--language"
                "nu"
              ];
              cmd = topiaryWrapper;
            }
        );
      };
      treesitter.grammarPackages = [ tsGrmrPkgs.nu ];
    };
  };
}
