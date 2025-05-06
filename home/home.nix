{ config, pkgs, ... }:
{
  home.username      = "martin";
  home.homeDirectory = "/home/martin";
  home.stateVersion  = "23.05";

  imports = [ ./programs.nix ./dotfiles.nix ];
}
