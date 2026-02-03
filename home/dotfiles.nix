{ pkgs,config, ... }:
let 
OUSL = config.lib.file.mkOutOfStoreSymlink;

dotfilesPath= "/etc/nixos/home/dotfiles";
dotfiles = subpath:
OUSL "${dotfilesPath}/${subpath}";
in
{
    home.file.".zshrc".source             =dotfiles ".zshrc";
    home.file.".tmux.conf".source         =dotfiles ".tmux.conf";
    home.file.".ideavimrc".source         =dotfiles ".ideavimrc";
    home.file.".gitconfig".source         =dotfiles ".gitconfig";
    home.file.".config/nvim"= {
        source = dotfiles "nvim";
        recursive = true;
    };
    # Hyprland config is now managed via wayland.windowManager.hyprland in programs.nix
    # But we still need to copy the additional config files that are sourced
    home.file.".config/hypr/animations.conf".source = dotfiles "hypr/animations.conf";
    home.file.".config/hypr/autostart.conf".source = dotfiles "hypr/autostart.conf";
    home.file.".config/hypr/binds.conf".source = dotfiles "hypr/binds.conf";
    home.file.".config/hypr/design.conf".source = dotfiles "hypr/design.conf";
    home.file.".config/hypr/env.conf".source = dotfiles "hypr/env.conf";
    home.file.".config/hypr/hypridle.conf".source = dotfiles "hypr/hypridle.conf";
    home.file.".config/hypr/hyprlock.conf".source = dotfiles "hypr/hyprlock.conf";
    home.file.".config/hypr/hyprpaper.conf".source = dotfiles "hypr/hyprpaper.conf";
    home.file.".config/hypr/input.conf".source = dotfiles "hypr/input.conf";
    home.file.".config/hypr/layout.conf".source = dotfiles "hypr/layout.conf";
    home.file.".config/hypr/monitors.conf".source = dotfiles "hypr/monitors.conf";
    home.file.".config/hypr/programs.conf".source = dotfiles "hypr/programs.conf";
    home.file.".config/hypr/rules.conf".source = dotfiles "hypr/rules.conf";
    home.file.".config/hypr/scripts" = {
        source = dotfiles "hypr/scripts";
        recursive = true;
    };
    home.file.".config/hypr/wallpapers" = {
        source = dotfiles "hypr/wallpapers";
        recursive = true;
    };
# home.file.".config/swaync"= {
#     source =dotfiles "swaync";
# };
    home.file.".config/waybar"= {
        source =dotfiles "waybar";
    };
    home.file.".config/wallust"= {
        source =dotfiles "wallust";
    };
    home.file.".config/kitty"= {
        source =dotfiles "kitty";
    };
    home.file.".config/rofi/config.rasi".source         =dotfiles "rofi-config.rasi";

    home.file.".config/quickshell"= {
        source =dotfiles "quickshell";
    };


    home.file.".config/gtk-3.0/gtk.css".source         =dotfiles "gtk.css";
    home.file.".config/gtk-4.0/custom.css".source         = dotfiles "gtk.css";

    gtk = {
        enable = true;
        iconTheme.name   = "BeautyLine";
        iconTheme.package = pkgs.beauty-line-icon-theme;
        cursorTheme.name = "rose-pine-hyprcursor";
        cursorTheme.package = pkgs.rose-pine-hyprcursor;
        theme.name = "adw-gtk3";
        theme.package= pkgs.adw-gtk3;
        gtk4.extraCss = ''
            @import url("file://${builtins.toString config.home.homeDirectory}/.config/gtk-4.0/custom.css");
        '';
    };
    qt = {
        enable = true;

        style = {
            name = "adwaita";           
            package = pkgs.adwaita-qt;
        };

        platformTheme.name = "qtct";
    };

    xdg.configFile."qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=adwaita
            icon_theme=BeautyLine
            '';

    xdg.configFile."qt6ct/qt6ct.conf".text = ''
        [Appearance]
        style=adwaita
            icon_theme=BeautyLine
            '';

}
