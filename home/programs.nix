{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh = {
    enable  = true;
    theme   = "robbyrussell";
    plugins = [ "git" "fzf" "docker" "gitflow" ];
  };

  services.gpg-agent.enable           = true;
  services.gpg-agent.enableSSHSupport = true;
  services.swaync.enable              = true;
services.udiskie.enable = true;
programs.podman.enable = true;
  home.packages = with pkgs; [
    # Bluetooth & power
    blueman bluez bluez_utils brightnessctl

    # Monitoring & info
    btop htop fastfetch gnome-system-monitor powertop power_options_gtk

    # Graphics & screenshots
    eog gimp grim slurp swappy

    # CLI utilities
    eza fzf git lazygit ripgrep bat unzip zip wget cliphist

    # Browsers & editors
    firefox neovim kitty

    # Dev toolchains
    go nodejs npm php python314Full

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
    waybar waybar-battery waybar-cpu


    #printer icons
    print-manager
  ];
}
