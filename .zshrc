# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey "^R" history-incremental-search-backward

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/andres/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
source $HOME/.aliases


VIMODE='❯'
function zle-line-init zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/:}/(main|viins)/❯}"
 zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# PROMPT Customization (inspired by https://github.com/sindresorhus/pure)

DEFAULT_USERNAME='andres'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' formats ' %b'
zstyle ':vcs_info:git*' actionformats ' %b|%a'

# enable prompt substitution
setopt PROMPT_SUBST

# Only show username if not default
[ $USER != $DEFAULT_USERNAME ] && local username='%n@%m '

# Fastest possible way to check if repo is dirty
git_dirty() {
	# check if we're in a git repo
	command git rev-parse --is-inside-work-tree &>/dev/null || return
	# check if it's dirty
	command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo '*'
}

precmd() {
	vcs_info
	PROMPT='%F{blue}%~%F{236}$vcs_info_msg_0_`git_dirty` $username%f${VIMODE} '
}
# End of PROMPT

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# Env variables
# export JAVA_HOME="$(/usr/libexec/java_home)"
# export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
# export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
# export EC2_HOME="/opt/boxen/homebrew/Library/LinkedKegs/ec2-api-tools/jars"
# export AWS_AUTO_SCALING_HOME="/opt/boxen/homebrew/Library/LinkedKegs/auto-scaling/jars"

export EDITOR=vim

export PYTHONSTARTUP=~/.pythonrc
