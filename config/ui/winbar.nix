{
  colors,
  config,
  lib,
  ...
}:
{
  options.ui.winbar = {
    enable = lib.mkEnableOption "enable winbar module";
  };
  config = lib.mkIf config.ui.winbar.enable {
    highlightOverride = with colors; {
      NavicSeparator = {
        fg = gui.primaryContent;
        ctermfg.__raw = cterm.primaryContent;
      };
      NavicText = {
        fg = gui.primaryContent;
        ctermfg.__raw = cterm.primaryContent;
      };
      NavicIconsFile = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsModule = {
        fg = gui.violet;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsNamespace = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsPackage = {
        fg = gui.violet;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsClass = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsMethod = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsProperty = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsField = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsConstructor = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsEnum = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsInterface = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsFunction = {
        fg = gui.violet;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsVariable = {
        fg = gui.magenta;
        ctermfg.__raw = cterm.magenta;
      };
      NavicIconsConstant = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsString = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsNumber = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsBoolean = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsArray = {
        fg = gui.orange;
        ctermfg.__raw = cterm.orange;
      };
      NavicIconsObject = {
        fg = gui.blue;
        ctermfg.__raw = cterm.blue;
      };
      NavicIconsKey = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsNull = {
        fg = gui.red;
        ctermfg.__raw = cterm.red;
      };
      NavicIconsEnumMember = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsStruct = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsEvent = {
        fg = gui.yellow;
        ctermfg.__raw = cterm.yellow;
      };
      NavicIconsOperator = {
        fg = gui.violet;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsTypeParameter = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsTypeAlias = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      NavicIconsParameter = {
        fg = gui.violet;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsComponent = {
        fg = gui.green;
        ctermfg.__raw = cterm.orange;
      };
      NavicIconsFragment = {
        fg = gui.green;
        ctermfg.__raw = cterm.yellow;
      };
      NavicIconsStaticMethod = {
        fg = gui.cyan;
        ctermfg.__raw = cterm.cyan;
      };
      NavicIconsMacro = {
        fg = gui.green;
        ctermfg.__raw = cterm.violet;
      };
      NavicIconsText = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      WinBar = {
        bg = gui.backHighlight;
        ctermbg.__raw = cterm.background;
        bold = true;
      };
    };
    plugins = {
      lualine.settings = {
        inactive_winbar = {
          lualine_c = [
            "filetype"
          ];
        };
        winbar = {
          lualine_c = [
            "filetype"
            {
              __unkeyed-1 = "navic";
            }
          ];
        };
      };
      navic = {
        enable = true;
        luaConfig.post = ''
          if os.getenv('TERM') == 'linux' then
            require('nvim-navic').setup({
              icons = {
                enabled = false
              },
              separator = ' → ',
            })
          end
        '';
        settings = {
          highlight = true;
          icons = {
            File = "󰈙 ";
            Module = "󰏗 ";
            Namespace = " ";
            Package = "󰏖 ";
            Class = " ";
            Method = " ";
            Property = " ";
            Field = " ";
            Constructor = " ";
            Enum = " ";
            Interface = " ";
            Function = "󰡱 ";
            Variable = "󰫧 ";
            Constant = " ";
            String = " ";
            Number = "󰎠 ";
            Boolean = "◩ ";
            Array = " ";
            Object = " ";
            Key = "󰌋 ";
            Null = "󰟢 ";
            EnumMember = " ";
            Struct = " ";
            Event = " ";
            Operator = " ";
            TypeParameter = " ";
            TypeAlias = "󰓼 ";
            Parameter = "󰀫 ";
            Component = "󰨾 ";
            Fragment = "󰅴 ";
            StaticMethod = " ";
            Macro = "󰁌 ";
            Text = "󰉿 ";
          };
          lsp = {
            auto_attach = true;
          };
          separator = "  ";
        };
      };
    };
  };
}
