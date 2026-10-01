{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixvim = {
      url = "github:nix-community/nixvim?ref=nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    topiary = {
      url = "github:tweag/topiary";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-themes.url = "github:1gmar/color-themes";
  };

  outputs =
    {
      color-themes,
      nixpkgs,
      nixvim,
      topiary,
      ...
    }:
    let
      theme = color-themes.solarized;
      nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = ./config;
        inherit pkgs;
        extraSpecialArgs = {
          inherit theme;
          inherit system;
          topiary = {
            lib = topiary.lib.${system};
            inherit (topiary.packages.${system}) topiary-cli;
          };
          tsGrmrPkgs = pkgs.vimPlugins.nvim-treesitter.builtGrammars;
        };
      };
      pkgs = import nixpkgs {
        config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "vim-solarized8" ];
        inherit system;
      };
      system = "x86_64-linux";
      darkNvim = nvim.extend ./config/ui/dark-cterm-lualine.nix;
      mkNixvimWith =
        module:
        let
          finalNvim = nvim.extend module;
          finalTTYNvim = darkNvim.extend module;
        in
        pkgs.writeShellApplication {
          name = "nvim";
          text = ''
            if [[ "$TERM" == "linux" ]]; then
              exec ${pkgs.lib.getExe finalTTYNvim} "$@"
            else
              exec ${pkgs.lib.getExe finalNvim} "$@"
            fi
          '';
        };
    in
    {
      checks.${system} = {
        default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "Nvim";
        };
        tty-vim = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
          nvim = darkNvim;
          name = "Dark Nvim";
        };
      };
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [
          (mkNixvimWith {
            git.enable = true;
            lua.enable = true;
          })
        ];
      };
      formatter.${system} = pkgs.nixfmt;
      lib.mkNixvimWith = mkNixvimWith;
      packages.${system}.default = mkNixvimWith { };
    };
}
