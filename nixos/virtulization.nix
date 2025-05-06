{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable      = true;
  virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;
  virtualisation.podman.enable        = true;
}
