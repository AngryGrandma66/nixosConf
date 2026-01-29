{ config, pkgs, ... }:
{
  users.users.martin = {
    isNormalUser = true;
    home         = "/home/martin";
    shell        = pkgs.zsh;
    extraGroups  = [ "wheel" "networkmanager" "libvirtd" "audio" "video" "lp" "lpadmin" ];
  };
}
