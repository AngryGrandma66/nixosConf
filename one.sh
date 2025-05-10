#!/bin/sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /home/nixos/nixosConf/disko.nix
