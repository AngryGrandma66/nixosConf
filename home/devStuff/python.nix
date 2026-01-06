{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    python314
  ];
#
#  # Symlink multiple Python installs
  home.file."runtimes/python/3.14".source = "${pkgs.python314}";
#  home.file."runtimes/python/current".source = "${pkgs.python314}";
#
#  # Wrapper script in ~/bin so “python” always uses “current”
#  home.file."bin/python".text = ''
#    #!/usr/bin/env bash
#    exec ~/.runtimes/python/current/bin/python3 "$@"
#  '';
#  home.file."bin/pip".text = ''
#    #!/usr/bin/env bash
#    exec ~/.runtimes/python/current/bin/pip3 "$@"
#  '';
}

