{ pkgs, lib, ... }:
{
    services.kdeconnect.enable = true;
    programs.quickshell.enable = true;
services.easyeffects.enable = true;


    home.sessionVariables = {
        TERMINAL = "kitty";
    };

    xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/terminal" = [ "kitty.desktop" ];
    };





    programs.zsh.oh-my-zsh = {
        enable  = true;
        theme   = "robbyrussell";
        plugins = [ "git" "fzf" "docker" "gitflow" ];
    };

    services.gpg-agent.enable = true;
    services.swaync.enable    = true;
    services.udiskie.enable   = true;

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
# Bluetooth & power
        blueman bluez brightnessctl

# Monitoring & info
            btop htop fastfetch gnome-system-monitor powertop

# Graphics
            eog gimp 

# CLI utilities
            eza fzf git lazygit ripgrep bat unzip zip wget cliphist

# Browsers & editors
            firefox neovim kitty

# JetBrains IDEs (patched automatically)
            jetbrains.idea-ultimate
            jetbrains.webstorm
            jetbrains.phpstorm
            jetbrains.pycharm-professional
            jetbrains.clion

# Printer GUI
            system-config-printer

# vesktop
            vesktop

# waybar
            waybar

# printer icons
            kdePackages.print-manager

# rofi
            rofi

# obsidian
            obsidian

# hyprland tools
            hyprpaper hypridle hyprshot

# nm applet
            networkmanagerapplet

# mpris
            mpvScripts.mpris playerctl

# calibre
  #          calibre

# thunar
            file-roller

# nerd Font
            nerd-fonts.jetbrains-mono

            wallust tlp

            wineWowPackages.wayland winetricks wineWowPackages.fonts

            yazi

            ungoogled-chromium
            ciscoPacketTracer8
            keepassxc
            jq

socat
            caprine

            obs-studio
            nix-search-tv


            vlc


            calibre
            hyprlock
            hypridle
            calibre


            gnumake

            ninja_1_11
 
            galaxy-buds-client


            file

            xxd
            ];

}

