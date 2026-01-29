{ config, ... }:
{
    security.sudo.enable       = true;
    nixpkgs.config.allowUnfree = true;
    security.polkit.enable = true;



    nixpkgs.config.permittedInsecurePackages = [
        "libxml2-2.13.8"
            "ciscoPacketTracer8-8.2.2"
    ];


    services.journald = {
        storage = "persistent";
        extraConfig = ''
            SystemMaxUse=200M
            RuntimeMaxUse=100M
            '';

    };
    
#programs.wireshark.enable = true;
#programs.wireshark.usbmon.enable = true;
#programs.wireshark.dumpcap.enable = true;

}
