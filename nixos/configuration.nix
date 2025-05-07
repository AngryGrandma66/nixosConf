{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./sddm.nix
    ./sound.nix
    ./time.nix
    ./polkit.nix
    ./security.nix
    ./virtualization.nix
    ./networking.nix
    ./services.nix
    ./hyprland.nix
    ./users.nix
    ./printing.nix
    ./fonts.nix
    ./locale.nix
    ./power.nix
    ./trim.nix
    ./hibernate.nix
    ./filesystems.nix
    ./themes.nix
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion     = "24.11";
}
