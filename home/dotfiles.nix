{ pkgs,config, ... }:
{
    home.file.".zshrc".source             = ./dotfiles/.zshrc;
    home.file.".tmux.conf".source         = ./dotfiles/.tmux.conf;
    home.file.".ideavimrc".source         = ./dotfiles/.ideavimrc;
    home.file.".gitconfig".source         = ./dotfiles/.gitconfig;
    home.file.".config/nvim"= {
        source = ./dotfiles/nvim;
        recursive = true;
    };
    home.file.".config/hypr"= {
        source = ./dotfiles/hypr;
        recursive = true;
    };
    home.file.".config/swaync"= {
        source = ./dotfiles/swaync;
        recursive = true;
    };
    home.file.".config/configScripts"= {
        source = ./dotfiles/configScripts;
        recursive = true;
    };
    home.file.".config/waybar"= {
        source = ./dotfiles/waybar;
        recursive = true;
    };
    home.file.".config/wallust"= {
        source = ./dotfiles/wallust;
        recursive = true;
    };
    home.file.".config/kitty"= {
        source = ./dotfiles/kitty;
        recursive = true;
    };



    home.file.".config/gtk-3.0/gtk.css".source         = ./dotfiles/gtk.css;
    home.file.".config/gtk-4.0/gtk.css".source         = ./dotfiles/gtk.css;
    gtk = {
        iconTheme.name   = "BeautyLine";
        iconTheme.package = pkgs.beauty-line-icon-theme;
        cursorTheme.name = "rose-pine-hyprcursor";
        cursorTheme.package = pkgs.rose-pine-hyprcursor;
        theme.name = "adw-gtk3";
        theme.package= pkgs.adw-gtk3;
    };
}
