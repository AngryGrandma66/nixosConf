{ config, pkgs, ... }:
{
  home.username      = "martin";
  home.homeDirectory = "/home/martin";
  home.stateVersion  = "24.11";

  imports = [ ./programs.nix ./dotfiles.nix ];
}
