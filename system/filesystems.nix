{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    exfatprogs   # exFAT
    ntfs3g       # NTFS
  ];
}