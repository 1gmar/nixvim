{ config, lib, ... }:
let
  swap = "require('nvim-treesitter-textobjects.swap')";
  move = "require('nvim-treesitter-textobjects.move')";
  ts = "require('mini.ai').gen_spec.treesitter";
in
{
  options.edit.textobjects = {
    enable = lib.mkEnableOption "enable textobjects module";
  };
  config = lib.mkIf config.edit.textobjects.enable {
    keymaps = lib.mkIf config.languages.treesitter.enable [
      {
        action.__raw = "function()${swap}.swap_previous('@parameter.inner')end";
        key = "<leader>e";
        mode = "n";
        options.desc = "Swap parameter node l[e]ft";
      }
      {
        action.__raw = "function()${swap}.swap_next('@parameter.inner')end";
        key = "<leader>r";
        mode = "n";
        options.desc = "Swap parameter node [r]ight";
      }
      {
        action.__raw = "function()${move}.goto_next_start('@function.outer', 'textobjects')end";
        key = "]m";
        mode = [
          "n"
          "x"
          "o"
        ];
        options.desc = "Go to next start of a function node";
      }
      {
        action.__raw = "function()${move}.goto_previous_start('@function.outer', 'textobjects')end";
        key = "[m";
        mode = [
          "n"
          "x"
          "o"
        ];
        options.desc = "Go to previous start of a function node";
      }
      {
        action.__raw = "function()${move}.goto_next_end('@function.outer', 'textobjects')end";
        key = "]M";
        mode = [
          "n"
          "x"
          "o"
        ];
        options.desc = "Go to next end of a function node";
      }
      {
        action.__raw = "function()${move}.goto_previous_end('@function.outer', 'textobjects')end";
        key = "[M";
        mode = [
          "n"
          "x"
          "o"
        ];
        options.desc = "Go to previous end of a function node";
      }
    ];
    plugins = {
      treesitter-textobjects = {
        enable = config.languages.treesitter.enable;
        settings = {
          select = {
            lookahead = false;
            lookbehind = false;
            selection_modes = [ ];
            include_surrounding_whitespace = false;
          };
          move = {
            set_jumps = true;
          };
        };
      };
      mini-ai = {
        enable = true;
        settings = {
          search_method = "cover_or_next";
          custom_textobjects = {
            f.__raw = "${ts}({ a = '@function.outer', i = '@function.inner' })";
            a.__raw = "${ts}({ a = '@parameter.outer', i = '@parameter.inner' })";
          };
        };
      };
    };
  };
}
