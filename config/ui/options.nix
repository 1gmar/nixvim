{ config, lib, ... }:
{
  options.ui-options = {
    enable = lib.mkEnableOption "enable ui options module";
  };
  config = lib.mkIf config.ui-options.enable {
    opts = {
      background = "light";
      colorcolumn = "100";
      cursorline = true;
      linebreak = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      scrolloff = 8;
      showmode = false;
      signcolumn = "yes";
      wrap = true;
    };
  };
}
