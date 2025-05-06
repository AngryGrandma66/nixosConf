{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix       ./sddm.nix
    ./sound.nix      ./time.nix
    ./polkit.nix     ./security.nix
    ./virtualization.nix
    ./networking.nix ./services.nix
    ./hyprland.nix   ./users.nix
    ./printing.nix
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion     = "24.05";
}
