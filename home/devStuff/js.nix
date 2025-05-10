{ config, pkgs,lib, ... }:
{

    home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
    yarn
    ];
}

