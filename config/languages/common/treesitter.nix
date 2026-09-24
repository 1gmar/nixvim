{
  config,
  lib,
  tsGrmrPkgs,
  ...
}:
{
  options.treesitter = {
    enable = lib.mkEnableOption "enable treesitter module";
  };
  config = lib.mkIf config.treesitter.enable {
    keymaps = [
      {
        action.__raw = ''
          function()
            vim.cmd.normal('v')
            require 'vim.treesitter._select'.select_parent(vim.v.count1)
          end
        '';
        key = "<C-CR>";
        mode = "n";
      }
      {
        action.__raw = ''
          function()
            require 'vim.treesitter._select'.select_parent(vim.v.count1)
          end
        '';
        key = "<C-k>";
        mode = "v";
      }
      {
        action.__raw = ''
          function()
            require 'vim.treesitter._select'.select_child(vim.v.count1)
          end
        '';
        key = "<C-j>";
        mode = "v";
      }
    ];
    plugins.treesitter = {
      enable = true;
      folding.enable = true;
      grammarPackages = with tsGrmrPkgs; [
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
