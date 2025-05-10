export ZSH="$HOME/.local/share/oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export GTK_THEME=Adwaita-dark

alias rebuild='sudo nixos-rebuild switch --flake /etc/nixos#martin'
alias config='cd /etc/nixos'

alias ls='eza'
# long, human-readable, all files, dirs first
alias ll='eza -lha --group-directories-first'
# include hidden files, no total line
alias la='eza -lAh --group-directories-firs

export FZF_DEFAULT_COMMAND='eza -a --color=always'
# add a nice layout & border
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# shorthand to launch fzf
alias fzf='fzf'
# “f” opens fzf and cd’s into selected directory
fd() {
  local dir
  dir=$(eza -ad --color=always | fzf --ansi) && cd "$dir"
}


# default bat use: numbered lines, paging if needed
alias bat='bat --style=numbers --paging=always'
# quick “cat”-style dump (no paging)
alias cat='bat --style=plain --paging=never'
# preview in fzf
export FZF_PREVIEW_COMMAND='bat --style=numbers --color=always {}'