{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nodejs_22
    nodePackages.pnpm
    yarn
  ];

  # Symlink Node.js runtime
  home.file."runtimes/node/22".source = "${pkgs.nodejs_22}";

  # By default, point “current” at Node 18:
  home.file."runtimes/node/current".source = "${pkgs.nodejs_22}";

  # Wrapper scripts in ~/bin so “node” and “npm” always use “current”
  home.file."bin/node".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/node/current/bin/node "$@"
  '';
  home.file."bin/npm".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/node/current/bin/npm "$@"
  '';
  home.file."bin/npx".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/node/current/bin/npx "$@"
  '';
  # Optionally add pnpm and yarn wrappers:
  home.file."bin/pnpm".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/node/current/bin/pnpm "$@"
  '';
  home.file."bin/yarn".text = ''
    #!/usr/bin/env bash
    exec ~/.runtimes/node/current/bin/yarn "$@"
  '';
}

