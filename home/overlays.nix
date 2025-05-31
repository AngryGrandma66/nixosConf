{ config, pkgs,lib, ... }:
let
  zlibrary = import ../overlays/z-library-2.4.2 { inherit pkgs; };
in
{

  home.packages = with pkgs; [
    (buildFHSUserEnv {
      name       = "z-library-fhs";
      targetPkgs = _: [ zlibrary ];
      runScript  = "z-library";
      multiPkgs  = ps: [
        ps.glibc
        ps.glib
        ps.dbus
        ps.dbus-glib
        ps.gtk3
        ps.cairo
        ps.pango
        ps.gdk-pixbuf
        ps.atk
        ps.nss
        ps.nspr
        ps.cups
        ps.alsa-lib
        ps.xorg.libX11
        ps.xorg.libXcomposite
        ps.xorg.libXcursor
        ps.xorg.libXdamage
        ps.xorg.libXtst
        ps.xorg.libXrandr
        ps.xorg.libXfixes
        ps.xorg.libxcb
        ps.xorg.libXext
        ps.mesa
        ps.expat
        ps.libxkbcommon
        ps.udev
      ];
    })
  ];

  xdg.desktopEntries.zlibrary = {
    name        = "Z-Library";
    comment     = "Electron-based eBook reader";
    exec        = "z-library-fhs"; 
    type        = "Application";
  };
}
