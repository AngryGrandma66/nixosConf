{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    breeze-gtk
    breeze-icons
    adwaita-icon-theme
  ];
}