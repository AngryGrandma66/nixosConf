{ config, pkgs, ... }:
{


#virtualisation.podman.enable        = true;
    virtualisation.waydroid.enable        = true;
#  environment.systemPackages = with pkgs; [
#  nur.repos.ataraxiasjel.waydroid-script
#    ];
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
        };
    };

}
