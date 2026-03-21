{ config, lib, ... }:
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
      fileencoding = "utf-8";
      foldlevel = 99;
      splitbelow = true;
      splitright = true;
    };
  };
}
