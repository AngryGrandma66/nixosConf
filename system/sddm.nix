{ config, pkgs, ... }:
{
  # Turn on X11 (needed by SDDM)
  #services.xserver.enable = true;

  # SDDM display manager on X11 with Breeze theme
  services.displayManager.sddm  = {
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      where-is-my-sddm-theme
      kdePackages.qt5compat
    ];
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "where_is_my_sddm_theme";
    enableHidpi = true;
    settings = {
      General = {
        DisplayServer = "wayland";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
  ];


  }
