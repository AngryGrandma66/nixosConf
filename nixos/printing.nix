{ config, pkgs, ... }:
{
  # Enable CUPS print server and common drivers
  services.printing = {
    enable  = true;
    drivers = [ pkgs.gutenprint pkgs.cups-filters ];
    browsing = true;  # auto-add discovered printers
    browsedConf = ''
      BrowseProtocols all
      CreateIPPPrinterQueues All
    '';
  };

  # mDNS/DNS-SD discovery for network printers
  services.avahi = {
    enable      = true;
    nssmdns4     = true;  # lets you resolve printer.local hostnames
    openFirewall= true;  # opens UDP/5353 for discovery
  };

  # Make the Printer GUI tool available
  environment.systemPackages = [ pkgs.system-config-printer ];
}
