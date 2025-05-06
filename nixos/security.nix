{ config, ... }:
{
  security.sudo.enable       = true;
  nixpkgs.config.allowUnfree = true;
}
