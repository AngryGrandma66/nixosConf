{ config, pkgs, ... }:
{
  # Allow real-time threads (needed by PipeWire)
  security.rtkit.enable = true;

  # PipeWire audio/video server configuration
  services.pipewire = {
    enable = true;

    # ALSA backend (including 32-bit support)
    alsa = {
      enable        = true;
      support32Bit  = true;    # ← now correctly nested under `alsa`
    };

    # PulseAudio compatibility
    pulse.enable = true;

    # JACK compatibility (disable unless you need it)
    jack.enable = false;
  # Use WirePlumber as the PipeWire policy/session manager
  wireplumber.enable = true;
  };



  environment.systemPackages = with pkgs; [
      pavucontrol  # Pulse/PipeWire GUI mixer
      pamixer      # Terminal mixer
    ];
}