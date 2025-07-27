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
            ./locale.nix
            ./power.nix
            ./trim.nix
            ./hibernate.nix
            ./filesystems.nix
            ./themes.nix
            ./thunar.nix
            ./ldfix.nix
            ];
    nix.extraOptions = ''
        experimental-features = nix-command flakes
        '';

    nixpkgs.config.allowUnfree = true;
    system.stateVersion     = "24.11";
}
