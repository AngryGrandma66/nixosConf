{ config, ... }:
{
      networking.firewall.allowedUDPPorts = [ 67 68 53 ];
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.networkmanager.enable = true;
  networking.firewall.enable       = true;
    networking.firewall = rec {
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = [ { from = 1714; to = 1764; } ]; 
        };
}
