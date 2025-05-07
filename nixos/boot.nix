{ config, pkgs, ... }:
{
  boot.loader.grub.enable                = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device                = "/dev/sda";
  hardware.cpu.intel.updateMicrocode     = true;
}
