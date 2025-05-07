{ config, ... }:
{
  security.sudo.enable       = true;
  nixpkgs.config.allowUnfree = true;

services.journald = {
  storage = "persistent";
  extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
  '';

};
}
