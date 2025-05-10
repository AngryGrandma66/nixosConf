{ config, pkgs, ... }:
{
services.fstrim.enable = true;

  services.fstrim.interval = "weekly";
   }
