{ pkgs,config, ... }:
{

    home.file.".zshrc".source             = ./dotfiles/.zshrc;
    home.file.".tmux.conf".source         = ./dotfiles/.tmux.conf;
    home.file.".ideavimrc".source         = ./dotfiles/.ideavimrc;
    home.file.".config/kitty/kitty.conf".source = ./dotfiles/kitty.conf;
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

    gtk = {
        iconTheme.name   = "BeautyLine";
        iconTheme.package = pkgs.beauty-line-icon-theme;
    };
}
