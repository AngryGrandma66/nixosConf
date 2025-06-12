
{ config, pkgs, ... }:
{
    stylix = {
        enable = true;
        image = ./wallpaper6.png;
        polarity="dark";



        cursor = {
            package = pkgs.rose-pine-cursor;
            name = "rose-pine-cursor";
            size = 10;
        };
        fonts = {
            monospace = {
                package = pkgs.nerd-fonts.jetbrains-mono;
                name = "JetBrainsMono Nerd Font Mono";
            };
            sansSerif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Sans";
            };
            serif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Serif";
            };
            sizes = {
                applications = 11;
                terminal = 11;
                desktop = 10;
                popups = 10;
            };
        };

    };
}
