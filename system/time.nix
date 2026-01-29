{ config, ... }:
{
  time.timeZone            = "Europe/Prague";
  services.timesyncd.enable = true;
}
