{ config, pkgs, ... }:
{
  boot.loader.grub.enable                = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device                = "/dev/vda";
  hardware.cpu.intel.updateMicrocode     = true;
}
