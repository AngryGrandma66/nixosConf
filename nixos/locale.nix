{
  i18n.consoleKeyMap = "cz-qwerty";     # for virtual consoles
  services.xserver = {
    enable = true;
    xkb = {
      layout = ["us" "cz" ];           # primary , US fallback Czech
      options = "grp:alt_shift_toggle"; # use Alt-Shift to switch
    };
  };
}