# nixos/hibernate.nix
{ config, lib, ... }:
{
#########################
# 1) Swap / resume device
#########################

# Make sure you have a swap partition at /dev/sda3 (or adjust to your label/UUID).
# This partition must be at least as large as your RAM.
    swapDevices = [
    { device = "/dev/nvme0n1p3"; }
    ];

# Tell the kernel and initrd where to find the resume image.
# If you use a swap *file* instead, set boot.resumeDevice to the *partition*
# and, if needed, add resume_offset via boot.kernelParams.
    boot.resumeDevice = "/dev/nvme0n1p3";

################################
# 2) Deep sleep (S3) instead of s2idle
################################
    boot.kernelParams = [
        "resume=/dev/nvme0n1p3"
            "mem_sleep_default=deep"
    ];

########################################################
# 3) Suspend-then-hibernate: first RAM, then after 30 minutes
########################################################
    systemd.sleep.extraConfig = ''
        [Sleep]
        SuspendState=mem
            HibernateDelaySec=30min
            '';

######################################################
# 4) Handle lid, power, suspend and hibernate keys
######################################################
    services.logind = {
# On lid close: suspend, then after HibernateDelaySec → hibernate
        lidSwitch              = "suspend-then-hibernate";

# Power key immediately hibernates
        powerKey               = "hibernate";
# Long-press still powers off
        powerKeyLongPress      = "poweroff";

# Dedicated hibernate key (if your laptop has one)
        hibernateKey           = "hibernate";

# Suspend key just suspends
        suspendKey             = "suspend";
    };
    systemd.services.acpiWakeupAll = {
        description = "Enable all ACPI wake-up devices";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = ''
#!/bin/sh
                for D in $(grep disabled /proc/acpi/wakeup | awk '{print $1}'); do
                    echo $D > /proc/acpi/wakeup
                        done
                        '';
        };
    };
}
