{ config, ... }:
{
  home.file.".zshrc".source             = ./dotfiles/.zshrc;
  home.file.".tmux.conf".source         = ./dotfiles/.tmux.conf;
  home.file.".config/nvim/init.vim".source = ./dotfiles/init.vim;
  home.file.".ideavimrc".source         = ./dotfiles/.ideavimrc;
  home.file.".config/kitty/kitty.conf".source = ./dotfiles/kitty.conf;
  home.file.".config/hyprland/hyprland.conf".source = ./dotfiles/hyprland.conf;
  home.file.".config/waybar/config".source = ./dotfiles/waybar-config;
  home.file.".gitconfig".source         = ./dotfiles/.gitconfig;
}
