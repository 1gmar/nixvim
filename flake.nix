{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixvim, ...}: let
    system = "x86_64-linux";
    config = import ./nixvim.nix;
    nvim = nixvim.legacyPackages.${system}.makeNixvim config;
  in {
    checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
      inherit nvim;
      name = "Neovim";
    };
    nixvimModule = config;
    homeManagerModules.nixvim = nixvim.homeManagerModules.nixvim;
    packages.${system}.default = nvim;
  };
}
