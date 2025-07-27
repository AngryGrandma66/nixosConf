{
    description = "Martin’s NixOS + Home Manager flake";

    inputs = {
        nixpkgs.url    = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager,nixpkgs-2505,nur, ... }:
        let
        system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
    pkgs-2505= import nixpkgs-2505 { inherit system; config = { allowUnfree = true; }; };
    in {
        nixosConfigurations.martin = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ ./system/configuration.nix
                    nur.modules.nixos.default
                home-manager.nixosModules.home-manager{
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true; 
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.martin = import ./home/home.nix;
                    home-manager.extraSpecialArgs = {

                inherit pkgs-2505;
            };
                }
            ];
        };
    };
}
