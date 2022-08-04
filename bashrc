# HELPER METHODS

# determines if method or call exists in bash
command_exists () {
  type "$1" &> /dev/null ;
}

# if in a git directory parses out the branch you are on
function parse_git_branch {
 ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

# Terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Bash Completion on Mac OSX
if command_exists brew ; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bashrc_private ]; then
  . ~/.bashrc_private
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

if command_exists oh-my-posh; then
  themes_dir=$(brew --prefix oh-my-posh)
  eval "$(oh-my-posh init bash --config ${themes_dir}/themes/peru.omp.json)"
fi

# Set up PS1 with directory and git branch if oh-my-posh not installed, otherwise assume that theme covers it
if ! command_exists oh-my-posh; then
  GREEN="\[\033[0;32m\]"
  YELLOW="\[\033[0;33m\]"
  RESETCOLOR="\[\e[00m\]"

  # set up command line colors (show git branch if it exists)
  PS1="$GREEN\u@\h \w$YELLOW \$(parse_git_branch)$GREEN $RESETCOLOR"
fi

# RVM Helpers
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# asdf Helpers
if command_exists asdf; then
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
fi

# give RVM a chance to load after tmux split
cd ..; cd -

export JAVA_HOME=/usr/lib/jvm/java-7-oracle/
export EDITOR=vim
export BUNDLE_EDITOR=vim

export GITHUB_UPSTREAM=origin

function pr_for_sha {
  git log --merges --ancestry-path --oneline $1..master | grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2-
}
