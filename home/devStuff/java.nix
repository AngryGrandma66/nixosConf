{ config, pkgs,lib, ... }:
{

    home.packages = with pkgs; [
        jdk23
            maven
            gradle
    ];
}
