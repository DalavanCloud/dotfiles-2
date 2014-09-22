fpath=($HOME/.zsh/zsh-completions $fpath)

autoload -U compinit promptinit
compinit
promptinit;

zstyle ':completion::complete:*' use-cache 1

setopt prompt_subst

autoload colors zsh/terminfo
if [[ "$TERM_PROGRAM" == "DTerm" ]]; then
	PR_COLOR=
	PR_NOCOLOR=
else
	if [[ "$terminfo[colors]" -ge 8 ]]; then
		colors
	fi

	for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
		eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
		eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
		(( count = $count + 1 ))
	done
	PR_NOCOLOR="%{$terminfo[sgr0]%}"

	if [[ "$USER" == "root" ]]; then
		PR_COLOR=$PR_RED
	elif [[ -f "$HOME/.zgreen" ]]; then
		PR_COLOR=$PR_LIGHT_GREEN
	else
		PR_COLOR=$PR_YELLOW
	fi
fi
case $TERM in
    xterm*)
	preexec () {print -Pn "\e]0;%n@%m: *$1\a"}
        precmd () {print -Pn "\e]0;%n@%m: %c\a"}
        ;;
esac

PROMPT="${PR_COLOR}[%n@%m %c]#${PR_NOCOLOR}"
#PROMPT="${PR_COLOR}[%n@mac %c]#${PR_NOCOLOR}"
HISTFILE=~/.zhistory
HISTSIZE=5120
SAVEHIST=$HISTSIZE
DIRSTACKSIZE=20

setopt  APPEND_HISTORY
setopt  HIST_IGNORE_ALL_DUPS
setopt  HIST_IGNORE_SPACE
setopt  HIST_REDUCE_BLANKS
setopt  No_Beep

export EDITOR=vim
export PAGER=less
export CLICOLOR=1

# up & down
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
# home & end
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

LANG=en_US.UTF-8

###############################################################################
### OS-specific tweaks

case `uname` in
    Linux)
	alias ls="ls --color=auto"
	alias iptl="iptables -n -v -L"
	export LESS="-R -M --shift 5"
        ;;
    FreeBSD)
	LANG=C
	LC_MESSAGES=C
	#alias ipfw="sudo ipfw"
	#alias pfctl="sudo pfctl"
        ;;
    Darwin)
	# OSX specific
	setopt no_ignore_eof
	setopt no_correct_all
	export LESS="-r"
        ;;
esac

###############################################################################
### common aliases

alias ll="ls -alF"
alias vi=vim
#alias tcpdump="sudo tcpdump"
#alias trafshow="sudo trafshow"
#alias arping="sudo arping"
#alias ping="sudo ping"
alias grep="grep --color"
#alias pingp="sudo ping -s 1470 -i 0.02 -c 256"
alias tm="tail /var/log/messages"
alias tmf="tail -f /var/log/messages"
#alias pp="sudo ping -s 1470 -i 0.02 -c 256"

# strip ANSI escapes
alias stresc='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

# openvz
alias vzl="vzlist -ao ctid,status,name,ip | sed 's/^.*running.*$/\x1b[32m\0\x1b(B\x1b[m/'"
alias vzl2="vzlist -ao ctid,status,name,hostname | sed 's/^.*running.*$/\x1b[32m\0\x1b(B\x1b[m/'"
alias vzenter="vzctl enter"

alias spec=rspec

###############################################################################

export PATH="${HOME}/bin:/usr/local/bin:${PATH}:/usr/sbin:$HOME/android/sdk/tools:$HOME/android/sdk/platform-tools"
export PATH="${PATH}:/opt/local/bin:${HOME}/.gem/ruby/2.0.0/bin"

# https://gist.github.com/4136373
export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_FREE_MIN=200000

[[ -s "$HOME/.ec2/keys.sh" ]] && . "$HOME/.ec2/keys.sh" 

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

GREP_OPTIONS="--exclude-dir .git"
