{ config, pkgs,lib, ... }:
{

  home.packages = with pkgs; [
    libgccjit
    cmake

];
}
