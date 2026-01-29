{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    openssl
    pkg-config
    cargo
    cargo-deny
    cargo-edit
    rust-analyzer
    rustc          
  ];

  home.file."runtimes/rust/current".source = "${pkgs.rustc}";

  # Wrapper scripts in ~/bin so “cargo” and “rustc” always use “current”
  home.file."bin/rustc".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/rust/current/bin/rustc "$@"
  '';
  home.file."bin/cargo".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/rust/current/bin/cargo "$@"
  '';
  home.file."bin/rust-analyzer".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/rust/current/bin/rust-analyzer "$@"
  '';
}

