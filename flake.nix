{
    description = "Martin’s NixOS + Home Manager flake";

    inputs = {
        nixpkgs.url    = "github:NixOS/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
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
            modules = [ ./system/configuration.nix
                home-manager.nixosModules.home-manager{
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true; 
                    home-manager.users.martin = import ./home/home.nix;
                }
            ];
        };
    };
}
