{
  config,
  lib,
  ...
}: {
  options.autocommands = {
    enable = lib.mkEnableOption "enable autocommands module";
  };
  config = lib.mkIf config.autocommands.enable {
    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = ["BufWritePre"];
        pattern = ["*.nix"];
      }
      {
        command = "inoremap <buffer> <C-'> '''';<Esc>3ha";
        event = ["FileType"];
        pattern = ["nix"];
      }
    ];
  };
}
