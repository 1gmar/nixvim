{ theme, ... }: {
  _module.args.colors = theme.dark;
  opts.background = "dark";
  globals.solarized_t_Co = 16;
  highlightOverride = with theme.dark; {
    lualine_a_normal = {
      bold = true;
      nocombine = true;
      ctermbg.__raw = toString cterm.blue;
      ctermfg.__raw = toString cterm.background;
      bg = gui.blue;
      fg = gui.background;
    };
    lualine_b_normal = {
      nocombine = true;
      ctermbg.__raw = toString cterm.white;
      ctermfg.__raw = toString cterm.background;
      bg = gui.highlight;
      fg = gui.background;
    };
    lualine_c_normal = {
      nocombine = true;
      ctermbg.__raw = toString cterm.backHighlight;
      ctermfg.__raw = toString cterm.highlight;
      bg = gui.backHighlight;
      fg = gui.highlight;
    };
    lualine_a_insert = {
      bold = true;
      nocombine = true;
      ctermbg.__raw = toString cterm.green;
      ctermfg.__raw = toString cterm.background;
      bg = gui.green;
      fg = gui.background;
    };
    lualine_a_visual = {
      bold = true;
      nocombine = true;
      ctermbg.__raw = toString cterm.magenta;
      ctermfg.__raw = toString cterm.background;
      bg = gui.magenta;
      fg = gui.background;
    };
    lualine_a_replace = {
      bold = true;
      nocombine = true;
      ctermbg.__raw = toString cterm.red;
      ctermfg.__raw = toString cterm.background;
      bg = gui.red;
      fg = gui.background;
    };
    lualine_a_inactive = {
      bold = true;
      nocombine = true;
      ctermbg.__raw = toString cterm.backHighlight;
      ctermfg.__raw = toString cterm.primaryContent;
      bg = gui.backHighlight;
      fg = gui.primaryContent;
    };
    lualine_b_inactive = {
      nocombine = true;
      ctermbg.__raw = toString cterm.white;
      ctermfg.__raw = toString cterm.background;
      bg = gui.brightYellow;
      fg = gui.background;
    };
    lualine_c_inactive = {
      nocombine = true;
      ctermbg.__raw = toString cterm.backHighlight;
      ctermfg.__raw = toString cterm.secondaryContent;
      bg = gui.backHighlight;
      fg = gui.secondaryContent;
    };

    PmenuSbar = {
      ctermbg.__raw = toString cterm.white;
      bg = gui.secondaryContent;
    };
    PmenuSel = {
      link = "Visual";
    };
    PmenuThumb = {
      ctermbg.__raw = toString cterm.blue;
      bg = gui.primaryContent;
    };
    Visual = {
      ctermbg.__raw = toString cterm.white;
      ctermfg.__raw = toString cterm.background;
      bg = gui.secondaryContent;
      fg = gui.background;
    };
  };
  statusline.settings = {
    options = {
      icons_enabled = false;
      component_separators = {
        left = "|";
        right = "|";
      };
      section_separators = {
        left = "";
        right = "";
      };
      theme = "solarized_dark";
    };
  };
}
