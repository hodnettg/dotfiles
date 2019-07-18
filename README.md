# Dotfiles

A repo to make setting up defaults for Vim, Tmux, and Bashrc dead simple. To
use, simply clone into the machine of your choice and run `./install`

### Gotchas and Notes

* `ubuntu_colors.itemcolors` is a colors file for iTerm2 that can be imported
  under Profiles > Colors

* Comment out alias that maps nvim to vim if on system without neovim. If using Neovim
  use `:PlugInstall` to install plugins (vim plugins are managed manually via dotfiles)

* You may want to make sure git is using nvim as your default editor with:
  `git config --global core.editor "nvim"`
