{ config, pkgs, ... }:
{
  boot.loader.grub.enable                = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device                = "/dev/nvme0n1";
  hardware.cpu.intel.updateMicrocode     = true;


  zramSwap = {
    enable        = true;    # turn on zram swap
    memoryPercent = 20;      # use 20% of RAM for compressed swap
  };


   boot.loader.grub.extraEntries = ''
      submenu "Rollbacks" {
      }
    '';
    system.autoUpgrade.allowReboot = false;
}
