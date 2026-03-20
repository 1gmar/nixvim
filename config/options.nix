{
  config,
  lib,
  ...
}:
{
  options.vimOpts = {
    enable = lib.mkEnableOption "enable vimOpts module";
  };
  config = lib.mkIf config.vimOpts.enable {
    globals = {
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };
    opts = {
      # general
      fileencoding = "utf-8";
      foldlevel = 99;

      # indentation
      breakindent = true;
      expandtab = true;
      smartindent = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;

      # splits
      splitbelow = true;
      splitright = true;

      # ui
      background = "light";
      colorcolumn = "100";
      cursorline = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      showmode = false;
      signcolumn = "yes";

      # wrapping
      linebreak = true;
      scrolloff = 8;
      wrap = true;
    };
  };
}
