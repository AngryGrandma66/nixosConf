{
  description = "Martin’s NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url    = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
  in {
    nixosConfigurations.martin = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./nixos/configuration.nix ];
    };
    homeConfigurations.martin = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/home.nix ];
    };
  };
}
