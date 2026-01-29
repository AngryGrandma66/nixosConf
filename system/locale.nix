{ config, lib, pkgs, ... }:
{
  console.keyMap = "us";
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,cz" ;
      options = "grp:alt_shift_toggle"; # use Alt-Shift to switch
    };
  };
}
