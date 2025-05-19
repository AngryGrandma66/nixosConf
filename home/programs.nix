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

    services.swaync.settings.battery = {
        enable        = true;
        notifyOnLow   = true;   # pop-up at 15%
            notifyOnFull  = true;   # pop-up at 100%
            lowThreshold  = 15;
    };
    home.packages = with pkgs; [
# Bluetooth & power
        blueman bluez brightnessctl

# Monitoring & info
            btop htop fastfetch gnome-system-monitor powertop

# Graphics & screenshots
            eog gimp grim slurp swappy

# CLI utilities
            eza fzf git lazygit ripgrep bat unzip zip wget cliphist

# Browsers & editors
            firefox neovim kitty

# JetBrains IDEs (Ultimate with IdeaVim)
            pkgs.jetbrains.idea-ultimate
            pkgs.jetbrains.webstorm
            pkgs.jetbrains.phpstorm

# Screen-sharing client
            vesktop

# Printer GUI (if CUPS GUI needed)
            system-config-printer


#automatic mounting
            udiskie


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

#thunar
            xfce.thunar xfce.thunar-volman xfce.thunar-archive-plugin xarchiver file-roller
#nerd Font
            (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
            ];
}
