{
  config,
  lib,
  ...
}: {
  options.mini-git = {
    enable = lib.mkEnableOption "enable mini-git module";
  };
  config = lib.mkIf config.mini-git.enable {
    # TODO git blame --date=human config/git/mini-diff.nix | awk '{split($0, L, "("); split(L[1], H, " "); split(L[2], S, ")"); print H[1], S[1]}' | awk 'NF{NF--};1'
    autoCmd = [
      {
        callback.__raw = ''
          function(au_data)
            if au_data.data.git_subcommand ~= 'blame' then return end

            local win_src = au_data.data.win_source
            vim.wo.wrap = false
            vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
            vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

            vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
          end
        '';
        event = "User";
        pattern = ["MiniGitCommandSplit"];
      }
    ];
    keymaps = [
      {
        action = "<cmd>lua MiniGit.show_at_cursor()<cr>";
        key = "<leader>gs";
        mode = ["n" "x"];
      }
    ];
    plugins.mini.modules.git = {};
  };
}
