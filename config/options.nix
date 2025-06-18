{
  config,
  lib,
  ...
}: {
  options.vimOpts = {
    enable = lib.mkEnableOption "enable vimOpts module";
  };
  config = lib.mkIf config.vimOpts.enable {
    diagnostic.settings = {
      signs = true;
      underline = true;
      update_in_insert = false;
      virtual_lines = false;
      virtual_text = true;
    };
    opts = {
      background = "light";
      breakindent = true;
      cursorline = true;
      expandtab = true;
      fileencoding = "utf-8";
      foldlevel = 99;
      ignorecase = true;
      linebreak = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      scrolloff = 8;
      shiftwidth = 2;
      showmode = false;
      signcolumn = "number";
      smartcase = true;
      smartindent = true;
      softtabstop = 2;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      wrap = true;
    };
  };
}
