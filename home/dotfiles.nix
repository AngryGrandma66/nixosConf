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
    home.file.".config/hypr"= {
        source = dotfiles "hypr";
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
}
