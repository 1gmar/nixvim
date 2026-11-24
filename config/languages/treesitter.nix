{
  config,
  lib,
  tsGrmrPkgs,
  ...
}:
let
  action = prefix: suffix: sign: ''
    function()
      ${prefix}
      if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require 'vim.treesitter._select'.select_${suffix}(vim.v.count1)
      else
        vim.lsp.buf.selection_range(${sign}vim.v.count1)
      end
    end
  '';
in
{
  options.languages.treesitter = {
    enable = lib.mkEnableOption "enable treesitter module";
  };
  config = lib.mkIf config.languages.treesitter.enable {
    keymaps = [
      {
        action.__raw = action "vim.cmd.normal('v')" "parent" "";
        key = "<C-CR>";
        mode = "n";
      }
      {
        action.__raw = action "" "parent" "";
        key = "<C-k>";
        mode = "v";
      }
      {
        action.__raw = action "" "child" "-";
        key = "<C-j>";
        mode = "v";
      }
    ];
    plugins.treesitter = {
      enable = true;
      folding.enable = true;
      grammarPackages = with tsGrmrPkgs; [
        bash
        css
        csv
        gitcommit
        gitignore
        html
        javascript
        json
        markdown
        markdown_inline
        properties
        toml
        vim
        vimdoc
        xml
        yaml
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
  };
}
