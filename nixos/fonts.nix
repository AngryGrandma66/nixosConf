{ config, pkgs, ... }:
{
fonts.packages = with pkgs; [
  nerdfonts.jetbrains_mono
];}
