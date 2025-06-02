{
  config,
  lib,
  ...
}: {
  options.commons = {
    enable = lib.mkEnableOption "enable commons module";
  };
  config = lib.mkIf config.commons.enable {
    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = ["BufWritePre"];
        pattern = ["*.nix"];
      }
    ];
    diagnostic.settings = {
      signs = true;
      underline = true;
      update_in_insert = false;
      virtual_lines = false;
      virtual_text = true;
    };
    extraConfigLuaPost = ''
    '';
    extraConfigVim = ''
    '';
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      background = "light";
      expandtab = true;
      foldlevel = 99;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      smartindent = true;
      softtabstop = 2;
      tabstop = 2;
    };
  };
}
