export LANG="en_US.UTF-8"
export LC_COLLATE="C.UTF-8"
# history settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups
setopt hist_ignore_space

# emacs-like keybindings
bindkey -e

zstyle :compinstall filename '/home/spynad/.zshrc'

# aliases
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias sysupdate="sudo emaint sync -A && emerge -aDNuv @world"

# completion
autoload -U compinit promptinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

# prompt
promptinit; prompt gentoo

# zsh internal features
setopt correctall
setopt autocd

# hooks
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

source ~/.zsh/blox-zsh-theme/blox.zsh
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
