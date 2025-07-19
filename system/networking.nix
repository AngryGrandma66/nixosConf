{ config, ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.enable       = true;
    networking.firewall = rec {
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
        };
}
