{
  config,
  lib,
  pkgs,
  ...
}: {
  options.treesitter = {
    enable = lib.mkEnableOption "enable treesitter module";
  };
  config = lib.mkIf config.treesitter.enable {
    plugins.treesitter = {
      enable = true;
      folding = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<CR>";
            node_decremental = "<C-j>";
            node_incremental = "<C-k>";
            scope_incremental = "<C-h>";
          };
        };
      };
    };
  };
}
