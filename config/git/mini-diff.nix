{
  colors,
  config,
  lib,
  ...
}:
{
  options.git.mini-diff = {
    enable = lib.mkEnableOption "enable mini-diff module";
  };
  config = lib.mkIf config.git.mini-diff.enable {
    highlightOverride = with colors; {
      MiniDiffSignAdd = {
        fg = gui.green;
        ctermfg.__raw = cterm.green;
      };
      MiniDiffSignChange = {
        fg = gui.yellow;
        ctermfg.__raw = cterm.yellow;
      };
      MiniDiffSignDelete = {
        fg = gui.magenta;
        ctermfg.__raw = cterm.magenta;
      };
    };
    keymaps = [
      {
        action = "<cmd>lua MiniDiff.toggle_overlay()<cr>";
        key = "<leader>md";
        mode = "n";
      }
    ];
    plugins.mini-diff = {
      enable = true;
      luaConfig.post = ''
        if os.getenv('TERM') == 'linux' then
          require('mini.diff').setup({
            view = {
              style = 'sign',
              signs = { add = '█', change = '█', delete = '█' },
            },
          })
        end
      '';
      settings.view = {
        style = "sign";
        signs = {
          add = "▌";
          change = "▌";
          delete = "▌";
        };
      };
    };
  };
}
