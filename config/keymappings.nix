{
  config,
  lib,
  ...
}: {
  options.keymappings = {
    enable = lib.mkEnableOption "enable keymappings module";
  };
  config = lib.mkIf config.keymappings.enable {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        action = "<cmd>split<CR>";
        key = "<leader>wh";
        mode = "n";
      }
      {
        action = "<cmd>vsplit<CR>";
        key = "<leader>wv";
        mode = "n";
      }
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
      }
      {
        action = "<C-o>A;";
        key = "<A-;>";
        mode = "i";
      }
      {
        action = "<Esc>mxA;<Esc>`xa";
        key = "<A-S-;>";
        mode = "i";
      }
      {
        action = ":m .+1<CR>==";
        key = "<A-j>";
        mode = "n";
      }
      {
        action = "<Esc>:m .+1<CR>==gi";
        key = "<A-j>";
        mode = "i";
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "<A-j>";
        mode = "v";
      }
      {
        action = ":m .-2<CR>==";
        key = "<A-k>";
        mode = "n";
      }
      {
        action = "<Esc>:m .-2<CR>==gi";
        key = "<A-k>";
        mode = "i";
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "<A-k>";
        mode = "v";
      }
      {
        action = "<C-\\><C-n>";
        key = "<Esc>";
        mode = "t";
      }
      {
        action = "<C-\\><C-n>";
        key = "<C-[>";
        mode = "t";
      }
    ];
  };
}
