{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    php83
    phpPackages.composer
  ];

  # Symlink the PHP interpreter
  home.file."runtimes/php/83".source = "${pkgs.php83}";
  home.file."runtimes/php/current".source = "${pkgs.php83}";

  # Wrapper scripts in ~/bin so “php” and “composer” always use “current”
  home.file."bin/php".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/php/current/bin/php "$@"
  '';
  home.file."bin/composer".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/php/current/bin/composer "$@"
  '';
}

