#### HELPER METHODS ###########

# deletes a git branch
deleteBranch() {
  git branch -D $1
  git push origin :$1
}


#### ALIAS DEFINITIONS #########

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# quick alias to delete branch
alias delete_branch=deleteBranch

#assumes annotate gem is installed and in rails directory
alias annotate_models='annotate --exclude tests,fixtures,factories -p before'

# restarts Vbox Guest Additions Clipboard
alias restart_clipboard='pkill -f VBoxClient; VBoxClient --clipboard'

#Removes .orig files left over from mergetool after resolving conflicts
alias clean_merge='find -name *.orig -exec rm {} \;'
