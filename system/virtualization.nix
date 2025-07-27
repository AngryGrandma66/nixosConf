{ config, pkgs, ... }:
{
    virtualisation.podman.enable        = true;
    virtualisation.waydroid.enable        = true;
#  environment.systemPackages = with pkgs; [
#  nur.repos.ataraxiasjel.waydroid-script
#    ];
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
                enable = true;
                packages = [(pkgs.OVMF.override {
                        secureBoot = true;
                        tpmSupport = true;
                        }).fd];
            };
        };
    };

}
