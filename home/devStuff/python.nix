{ config, pkgs,lib, ... }:
{

    home.packages = with pkgs; [
    python314Full

    ];
}
