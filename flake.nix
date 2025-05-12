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
    config = import ./config;
    nvim = nixvim.legacyPackages.${system}.makeNixvim config;
  in {
    checks.${system}.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
      inherit nvim;
      name = "Neovim";
    };
    homeManagerModules.nixvim = nixvim.homeManagerModules.nixvim;
    legacyPackages = nixvim.legacyPackages;
    nixvimModule = config;
    packages.${system}.default = nvim;
  };
}
