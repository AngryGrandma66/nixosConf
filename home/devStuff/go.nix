{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    go
    gotools
  ];

  # Symlink the Go SDK under ~/runtimes/go/1.XX  (assumes pkgs.go is e.g. Go 1.21)
  home.file."runtimes/go/1.21".source = "${pkgs.go}";
  # Set the “current” pointer to that same path:
  home.file."runtimes/go/current".source = "${pkgs.go}";

  # Wrapper scripts in ~/bin so “go” always uses “current”
  home.file."bin/go".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/go/current/bin/go "$@"
  '';
  home.file."bin/gofmt".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/go/current/bin/gofmt "$@"
  '';
}

