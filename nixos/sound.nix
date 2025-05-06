{ config, pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable          = true;
    pulse.enable    = true;
    alsa.enable     = true;
    jack.enable     = false;
    support32Bit    = true;
    wireplumber.enable = true;
  };
}
