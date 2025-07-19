{ config, pkgs, ... }:
{
    boot.loader.grub = { 
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "/dev/nvme0n1";
        timeoutStyle = "hidden";
        };
    hardware.cpu.intel.updateMicrocode     = true;


    boot.kernelParams = [
        "button.lid_init_state=open"

            "intel_idle.max_cstate=9"        # allow the deepest package C‐state
            "processor.max_cstate=6"         # allow deep CPU C‐states

# Intel GPU runtime power‐management + panel self refresh
            "i915.enable_rc6=1"              # enable RC6 sleep states
            "i915.enable_psr=1"              # panel self‐refresh
            "i915.enable_fbc=1"              # frame buffer compression (if supported)
    ];
    powerManagement.cpuFreqGovernor = "schedutil";

    services.power-profiles-daemon.enable = true;
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
