{ config, ... }:
{
  security.sudo.enable       = true;
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;

services.journald = {
  storage = "persistent";
  extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
  '';

};
}
