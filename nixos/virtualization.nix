{ config, pkgs, ... }:
{
 virtualisation.libvirtd = {
  enable      = true;
  qemuPackage = pkgs.qemu_kvm;
  enable      = true;
  qemu = {
    enable  = true;
    package = pkgs.qemu_kvm;    # use new `.qemu.package` field
  };
 };
   virtualisation.podman.enable        = true;
}
