{ config, pkgs,lib, ... }:
{

    home.packages = with pkgs; [
    openssl
    pkg-config
    cargo
    cargo-deny
    cargo-edit
    rust-analyzer
    ];
}
