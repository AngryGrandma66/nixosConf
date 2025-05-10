{ config, pkgs,lib, ... }:
{
    imports = [ 
        ./c.nix  
        ./go.nix
        ./java.nix
        ./js.nix
        ./php.nix
        ./python.nix
        ./rust.nix
    ];
}
