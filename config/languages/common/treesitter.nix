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
    plugins.treesitter = {
      enable = true;
      folding.enable = true;
      grammarPackages = with tsGrmrPkgs; [
        css
        csv
        gitcommit
        gitignore
        html
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
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-CR>";
            node_decremental = "<C-j>";
            node_incremental = "<C-k>";
            scope_incremental = "<C-h>";
          };
        };
      };
    };
  };
}
