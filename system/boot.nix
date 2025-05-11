{ config, pkgs, ... }:
{
  boot.loader.grub.enable                = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device                = "/dev/nvme0n1";
  hardware.cpu.intel.updateMicrocode     = true;

  boot.kernelParams = [
    "button.lid_init_state=open"
    "i915.enable_psr=0"
  "i915.enable_rc6=0"
  ];

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
