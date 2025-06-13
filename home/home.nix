{ config, pkgs,lib, ... }:
{
  home.username      = "martin";
  home.homeDirectory = "/home/martin";
  home.stateVersion  = "25.05";

  imports = [ ./programs.nix ./dotfiles.nix ./devStuff ./overlays.nix];

    stylix = {
    enable = true;                # turn on Stylix in HM
    targets.kitty.enable = true;  # enable the Kitty theming target
  };
}
