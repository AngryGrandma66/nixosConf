{ config, pkgs, ... }:
{
  services.openssh.enable   = true;
  services.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    polkit_gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}
