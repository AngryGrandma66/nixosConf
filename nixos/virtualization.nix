{ config, pkgs, ... }:
{
 virtualisation.libvirtd = {
  enable      = true;
  qemu.package = pkgs.qemu_kvm;
 };
   virtualisation.podman.enable        = true;
}
