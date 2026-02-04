{ config, pkgs, ... }:
{
    services.openssh.enable   = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    programs.zsh.enable = true;
    services.gvfs.enable = true;
    services.fwupd.enable = true;



    hardware.openrazer.enable = true;
    environment.systemPackages = with pkgs; [
        polkit_gnome
            xdg-desktop-portal-gtk
            xdg-desktop-portal-hyprland
            python314
            hyprutils
            openrazer-daemon


nur.repos.mic92.hello-nur
    ];


}
