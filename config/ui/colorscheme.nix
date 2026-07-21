{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.color-scheme = {
    enable = lib.mkEnableOption "enable color-scheme module";
  };
  config = lib.mkIf config.color-scheme.enable {
    colorscheme = lib.mkDefault "solarized8";
    extraPlugins = with pkgs.vimPlugins; [
      (vim-solarized8.overrideAttrs {
        src = pkgs.fetchgit {
          url = "https://codeberg.org/lifepillar/vim-solarized8/";
          rev = "4ef98a611553a8093ae9e5af078ef6f94071e886";
          hash = "sha256-I0/WeERQ8pazhd68p35/Pt1SF8LYW2c7i7hYgp+1hsE=";
        };
      })
    ];
  };
}
