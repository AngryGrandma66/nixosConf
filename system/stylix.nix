
{ config, pkgs, ... }:
{
    stylix = {
        enable = false;
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
