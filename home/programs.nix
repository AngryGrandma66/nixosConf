{ pkgs,lib, ... }:
{
    programs.zsh.enable = true;
    programs.zsh.oh-my-zsh = {
        enable  = true;
        theme   = "robbyrussell";
        plugins = [ "git" "fzf" "docker" "gitflow" ];
    };

    services.gpg-agent.enable           = true;
    services.swaync.enable              = true;
    services.udiskie.enable = true;
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

# JetBrains IDEs 
            pkgs.jetbrains.idea-ultimate
            pkgs.jetbrains.webstorm
            pkgs.jetbrains.phpstorm


# Printer GUI (if CUPS GUI needed)
            system-config-printer


#automatic mounting
            udiskie
#vesktop
            vesktop
#waybar
            waybar


#printer icons
            kdePackages.print-manager

#rofi
            rofi-wayland
#obsidian
            obsidian
#hyprpaper
            hyprpaper
#hypridle
            hypridle
#hyprshot
            hyprshot
#nm applet
            networkmanagerapplet

#mpris for waybaraudio
            mpvScripts.mpris playerctl
#calibre
            calibre
#thunar
            file-roller
#nerd Font
            nerd-fonts.jetbrains-mono
            

            wallust
            ];
}
