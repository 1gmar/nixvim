{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixvim = {
      url = "github:nix-community/nixvim?ref=nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nufmt = {
      url = "github:nushell/nufmt";
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
      nufmt,
      topiary,
      ...
    }:
    let
      nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = ./config;
        inherit pkgs;
        extraSpecialArgs = {
          colors = color-themes.solarized.light;
          inherit system;
          nufmt = nufmt.packages.${system}.nufmt;
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
    in
    {
      checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
        nvim = nvim.extend { };
        name = "Nvim";
      };
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [
          (nvim.extend {
            git = {
              enable = true;
              mini-git.enableExtDiff = true;
            };
            languages.lua.enable = true;
          })
        ];
      };
      formatter.${system} = pkgs.nixfmt;
      packages.${system}.default = nvim;
    };
}
