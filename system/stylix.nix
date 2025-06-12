
{ config, pkgs, ... }:
{
    stylix = {
        enable = true;
        image = ./wallpaper6.png;
        autoEnable = true;
        polarity="dark";

        homeManagerIntegration = {
            autoImport = true;
            followSystem = true;
        };

        cursor = {
            package = pkgs.rose-pine-cursor;
            name = "rose-pine-cursor";
        };
        fonts = {
            monospace = {
                package = nerd-fonts.jetbrains-mono;
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
                applications = 15;
                terminal = 15;
                desktop = 15;
                popups = 15;
            };
        };

    }
}
