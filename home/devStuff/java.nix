{ config, pkgs, lib, ... }:

{
  #home.packages = with pkgs; [
  #  jdk23
  #  maven
  #  gradle
  #];

  ## Symlink the JDK(s) you want. Here we have only jdk23, but you could add others.
  #home.file."runtimes/java/23".source = "${pkgs.jdk23}";
  #home.file."runtimes/java/21".source = "${pkgs.jdk21}";
  ## Make “current” point at jdk23 by default:
  #home.file."runtimes/java/current".source = "${pkgs.jdk23}";

  ## Wrapper scripts in ~/bin so “java” and “javac” always use “current”
  #home.file."bin/java".text = ''
  #  #!/usr/bin/env bash
  #  exec ~/.runtimes/java/current/bin/java "$@"
  #'';
  #home.file."bin/javac".text = ''
  #  #!/usr/bin/env bash
  #  exec ~/.runtimes/java/current/bin/javac "$@"
  #'';
  #home.file."bin/jar".text = ''
  #  #!/usr/bin/env bash
  #  exec ~/.runtimes/java/current/bin/jar "$@"
  #'';
  # You can add more wrappers (javap, javadoc, etc.) if you need them.
}

