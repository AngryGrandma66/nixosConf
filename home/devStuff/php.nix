{ config, pkgs,lib, ... }:
{

    home.packages = with pkgs; [
    php
    phpPackages.composer
    ];
}
