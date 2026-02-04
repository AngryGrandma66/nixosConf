{ config, pkgs, ... }:
{
    programs.steam.enable = true;
    programs.gamescope = {
        enable = true;
        capSysNice = true;
    };
    programs.steam.gamescopeSession.enable = true;
}
