{ config, pkgs, ... }:
{
  # Turn on X11 (needed by SDDM)
  services.xserver.enable = true;

  # SDDM display manager on X11 with Breeze theme
  services.displayManager.sddm = {
    enable = true;
    theme  = "breeze";
  };}
