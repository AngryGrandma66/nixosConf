export ZSH="$HOME/.local/share/oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

rebuild() {
  local flake_dir="/etc/nixos"
  local host="martin"
  local commit_msg=${1:-"Update flake before rebuild"}

  (
    set -euo pipefail

    # 1) Evaluate the flake (no fragment on flake check)
    nix flake check "${flake_dir}"

    # 2) Add & commit only if there are staged changes
    git -C "${flake_dir}" add -A
    if ! git -C "${flake_dir}" diff --cached --quiet; then
      git -C "${flake_dir}" commit -m "$commit_msg"
    fi

    # 3) Rebuild (fragment needed for your host)
    sudo nixos-rebuild switch --flake "${flake_dir}#${host}"
  )
}
alias config='cd /etc/nixos'

alias ls='eza'
# long, human-readable, all files, dirs first
alias ll='eza -lha --group-directories-first'
# include hidden files, no total line
alias la='eza -lAh --group-directories-first'

export FZF_DEFAULT_COMMAND='eza -a --color=always'
# add a nice layout & border
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# shorthand to launch fzf
alias ff='fzf'
# “f” opens fzf and cd’s into selected directory
fd() {
  local dir
  dir=$(eza -ad --color=always | fzf --ansi) && cd "$dir"
}


# default bat use: numbered lines, paging if needed
alias bat='bat --style=numbers --paging=always'
# quick “cat”-style dump (no paging)
alias cat='bat --style=plain --paging=never'
alias ns="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history"
# preview in fzf
export FZF_PREVIEW_COMMAND='bat --style=numbers --color=always {}'
alias unfw= 'sudo systemctl restart NetworkManager'
