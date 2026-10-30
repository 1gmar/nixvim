{
  colors,
  config,
  lib,
  pkgs,
  ...
}:
{
  options.ui.color-scheme = {
    enable = lib.mkEnableOption "enable color-scheme module";
  };
  config = lib.mkIf config.ui.color-scheme.enable {
    colorscheme = lib.mkDefault "solarized8";
    extraConfigLuaPre = ''
      if os.getenv('TERM') == 'linux' then
        vim.g.solarized_t_Co = 16
        vim.o.background = 'dark'
      end
    '';
    extraPlugins = with pkgs.vimPlugins; [
      (vim-solarized8.overrideAttrs {
        src = pkgs.fetchgit {
          url = "https://codeberg.org/lifepillar/vim-solarized8/";
          rev = "4ef98a611553a8093ae9e5af078ef6f94071e886";
          hash = "sha256-I0/WeERQ8pazhd68p35/Pt1SF8LYW2c7i7hYgp+1hsE=";
        };
      })
    ];
    highlightOverride = with colors; {
      Cursor = {
        bg = gui.primaryContent;
        ctermbg.__raw = cterm.black;
        fg = gui.background;
        ctermfg.__raw = cterm.background;
      };
      ErrorMsg = {
        ctermbg.__raw = cterm.background;
        update = true;
      };
      FloatBorder = {
        bg = gui.background;
        ctermbg.__raw = cterm.background;
        fg = gui.highlight;
        ctermfg.__raw = cterm.highlight;
      };
      Normal = {
        ctermbg.__raw = cterm.background;
        ctermfg.__raw = cterm.primaryContent;
        update = true;
      };
      NormalFloat = {
        bg = gui.background;
        ctermbg.__raw = cterm.background;
        fg = gui.highlight;
        ctermfg.__raw = cterm.highlight;
      };
      PmenuSbar = {
        ctermbg.__raw = cterm.black;
        update = true;
      };
      PmenuSel = {
        link = "Visual";
      };
      PmenuThumb = {
        ctermbg.__raw = cterm.blue;
        update = true;
      };
      StatusLine = {
        ctermbg.__raw = cterm.background;
        ctermfg.__raw = cterm.blue;
        update = true;
      };
      StatusLineNC = {
        ctermbg.__raw = cterm.background;
        ctermfg.__raw = cterm.cyan;
        update = true;
      };
      Visual = {
        ctermbg.__raw = cterm.background;
        ctermfg.__raw = cterm.black;
        update = true;
      };
      VertSplit = {
        bg = gui.background;
        ctermbg.__raw = cterm.background;
        fg = gui.highlight;
        ctermfg.__raw = cterm.highlight;
      };
      WinSeparator = {
        bg = gui.background;
        ctermbg.__raw = cterm.background;
        fg = gui.highlight;
        ctermfg.__raw = cterm.highlight;
      };
    };
  };
}
