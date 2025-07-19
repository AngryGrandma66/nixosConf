{ config, pkgs,lib,pkgs-2505, ... }:
{
  home.username      = "martin";
  home.homeDirectory = "/home/martin";
  home.stateVersion  = "25.11";

  imports = [ ./programs.nix ./dotfiles.nix ./devStuff ./overlays.nix];
}
