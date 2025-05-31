{ config, pkgs, lib, ... }:

let
  # (Optionally) define a “current” C toolchain if you ever need to select one.
  # In this simple case, we’ll point “current” at the default gcc in pkgs.
  gccPkg = pkgs.gcc;
in
{
  home.packages = with pkgs; [
    libgccjit
    cmake
    gccPkg          # so that “gcc” / “g++” exist on your PATH
  ];

  # Create ~/runtimes/c/current → the gcc package (root of the store path)
  home.file."runtimes/c/current".source = "${gccPkg}";

  # If you want to version-pin different gcc releases, you could add:
  # home.file."runtimes/c/9".source  = "${pkgs.gcc9}";
  # home.file."runtimes/c/10".source = "${pkgs.gcc10}";
  # home.file."runtimes/c/11".source = "${pkgs.gcc11}";
  # Then repoint “current” to whichever you like.

  # Wrapper scripts in ~/bin so "gcc", "g++", "cmake" always use “current”
  home.file."bin/gcc".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/c/current/bin/gcc "$@"
  '';
  home.file."bin/g++".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/c/current/bin/g++ "$@"
  '';
  home.file."bin/cmake".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/c/current/bin/cmake "$@"
  '';
}

