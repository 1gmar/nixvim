{
  config,
  lib,
  nufmt,
  pkgs,
  tsGrmrPkgs,
  ...
}:
let
  nufmtConfig = pkgs.writers.writeJSON "nufmt-config.json" {
    indent = 2;
    indent_char = "space";
    line_length = 100;
    margin = 1;
    exclude = [ ];
  };
  fmtConfig = pkgs.runCommandLocal "nufmt-config.nuon" { nativeBuildInputs = [ pkgs.nushell ]; } ''
    nu -n -c 'open ${nufmtConfig} | to nuon -i 2' > $out
  '';
in
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
  config = lib.mkIf config.nushell.enable {
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
        packageFallback = true;
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
            name = 'nufmt',
            method = null_ls.methods.FORMATTING,
            filetypes = { 'nu' },
            generator = null_ls.formatter({
              args = { '--stdin', '-c', '${fmtConfig}' },
              command = '${lib.getExe nufmt}',
              to_stdin = true,
            })
          })
        '';
      };
      treesitter.grammarPackages = [ tsGrmrPkgs.nu ];
    };
  };
}
