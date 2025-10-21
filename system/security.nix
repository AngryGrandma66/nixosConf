{ config, ... }:
{
    security.sudo.enable       = true;
    nixpkgs.config.allowUnfree = true;
    security.polkit.enable = true;



    nixpkgs.config.permittedInsecurePackages = [
        "libxml2-2.13.8"
    ];
    services.journald = {
        storage = "persistent";
        extraConfig = ''
            SystemMaxUse=200M
            RuntimeMaxUse=100M
            '';

    };
}
