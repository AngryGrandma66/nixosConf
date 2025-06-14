{ pkgs,config, ... }:
let 
    OUSL = config.lib.file.mkOutOfStoreSymlink;
in
{
    home.file.".zshrc".source             =OUSL  ./dotfiles/.zshrc;
    home.file.".tmux.conf".source         =OUSL  ./dotfiles/.tmux.conf;
    home.file.".ideavimrc".source         =OUSL  ./dotfiles/.ideavimrc;
    home.file.".gitconfig".source         =OUSL  ./dotfiles/.gitconfig;
    home.file.".config/nvim"= {
        source = OUSL ./dotfiles/nvim;
        recursive = true;
    };
    home.file.".config/hypr"= {
        source = OUSL ./dotfiles/hypr;
        recursive = true;
    };
    home.file.".config/swaync"= {
        source =OUSL  ./dotfiles/swaync;
        recursive = true;
    };
    home.file.".config/waybar"= {
        source =ousl  ./dotfiles/waybar;
        recursive = true;
    };
    home.file.".config/wallust"= {
        source =OUSL  ./dotfiles/wallust;
        recursive = true;
    };
    home.file.".config/kitty"= {
        source =OUSL  ./dotfiles/kitty;
        recursive = true;
    };
    home.file.".config/rofi/config.rasi".source         =OUSL  ./dotfiles/rofi-config.rasi;



    home.file.".config/gtk-3.0/gtk.css".source         =OUSL  ./dotfiles/gtk.css;
    home.file.".config/gtk-4.0/custom.css".source         = OUSL ./dotfiles/gtk.css;

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
