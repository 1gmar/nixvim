{
  colors,
  config,
  lib,
  ...
}:
{
  options.ui.statusline = {
    enable = lib.mkEnableOption "enable statusline module";
  };
  config = lib.mkIf config.ui.statusline.enable {
    highlightOverride = with colors; {
      LuaLineDiffAdd = {
        fg = gui.green;
        bg = gui.backHighlight;
        ctermfg.__raw = cterm.green;
        ctermbg.__raw = cterm.background;
        nocombine = true;
      };
      LuaLineDiffChange = {
        fg = gui.yellow;
        bg = gui.backHighlight;
        ctermfg.__raw = cterm.yellow;
        ctermbg.__raw = cterm.background;
        nocombine = true;
      };
      LuaLineDiffDelete = {
        fg = gui.red;
        bg = gui.backHighlight;
        ctermfg.__raw = cterm.red;
        ctermbg.__raw = cterm.background;
        nocombine = true;
      };
    };
    plugins.lualine = {
      enable = true;
      luaConfig.post =
        with colors; # lua
        ''
          if os.getenv('TERM') == 'linux' then
            require('lualine').setup {
              options = {
                icons_enabled = false,
                component_separators = {
                  left = "│",
                  right = "│",
                },
                section_separators = {
                  left = "",
                  right = "",
                },
              },
            }
            local overrides = {
              lualine_a_normal = { ctermbg = ${cterm.blue}, ctermfg = ${cterm.background} },
              lualine_b_normal = { ctermbg = ${cterm.black}, ctermfg = ${cterm.background} },
              lualine_c_normal = { ctermbg = ${cterm.background}, ctermfg = ${cterm.highlight} },
              lualine_a_insert = { ctermbg = ${cterm.green}, ctermfg = ${cterm.background} },
              lualine_a_visual = { ctermbg = ${cterm.magenta}, ctermfg = ${cterm.background} },
              lualine_a_replace = { ctermbg = ${cterm.red}, ctermfg = ${cterm.background} },
              lualine_a_inactive = { ctermbg = ${cterm.background}, ctermfg = ${cterm.primaryContent} },
              lualine_b_inactive = { ctermbg = ${cterm.black}, ctermfg = ${cterm.background} },
              lualine_c_inactive = { ctermbg = ${cterm.background}, ctermfg = ${cterm.secondaryContent} },
            }
            for k, v in pairs(overrides) do
              v['update'] = true
              vim.api.nvim_set_hl(0, k, v)
            end
          end
        '';
      settings = {
        extensions = [ "man" ];
        options = {
          ignore_focus = [
            "mini-files"
            "neo-tree"
          ];
          theme = "solarized_light";
        };
        sections = {
          lualine_b = [ "branch" ];
          lualine_c = [
            {
              __unkeyed-1 = "diff";
              diff_color = {
                added = "LuaLineDiffAdd";
                modified = "LuaLineDiffChange";
                removed = "LuaLineDiffDelete";
              };
            }
            "filename"
            {
              __unkeyed-1 = "diagnostics";
              diagnostics_color = {
                error = "DiagnosticError";
                hint = "DiagnosticHint";
                info = "DiagnosticInfo";
                warn = "DiagnosticWarn";
              };
            }
          ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
            {
              __unkeyed-1 = "lsp_status";
              ignore_lsp = [ "null-ls" ];
            }
          ];
          lualine_y = [
            "progress"
            "%L"
          ];
        };
      };
    };
  };
}
