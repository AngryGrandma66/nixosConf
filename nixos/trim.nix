{ config, pkgs, ... }:
{
services.fstrim.enable = true;
services.fstrim.timerOptions = "--no-progress";
}
