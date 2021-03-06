# -------------------------------------------------------------------------------
# History
# -------------------------------------------------------------------------------

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Keep adding commands to history file as we execute them instead of waiting for
# shell to exit. If we execute a command, then open a new shell, that last executed
# command should be available in history.
setopt INC_APPEND_HISTORY

# Don't share history between sessions
setopt NO_SHARE_HISTORY

# Don't display duplicates of lines already found
setopt HIST_FIND_NO_DUPS

# Remove older entry from history if it matches newly added entry
setopt HIST_IGNORE_ALL_DUPS

# When writing out history file, older commands that duplicate newer ones are omitted
setopt HIST_SAVE_NO_DUPS


# -------------------------------------------------------------------------------
# Completion
# -------------------------------------------------------------------------------

# Auto select the first menu completion entry
setopt MENU_COMPLETE

# Move cursor to end of word whenever completion happens
setopt ALWAYS_TO_END

# Complete from both ends of a word
setopt COMPLETE_IN_WORD


# Use caching for completion
zstyle ':completion:complete:*' use-cache on
zstyle ':completion:complete:*' cache-path "${HOME}/.zcompcache"

# Group matches and add descriptions (taken from Prezto completions module)
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Directories (taken from Prezto completions module)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB


# -------------------------------------------------------------------------------
# Directories
# -------------------------------------------------------------------------------

# Automatically `cd` into directory if the entered command was just a directory name
setopt AUTO_CD

# `cd` should push old directory on to stack
setopt AUTO_PUSHD

# Prevent duplicates on stack
setopt PUSHD_IGNORE_DUPS

# Don't print directory name on doing `pushd`
setopt PUSHD_SILENT


# -------------------------------------------------------------------------------
# Cursor
# -------------------------------------------------------------------------------

_fix_cursor() {
   echo -ne '\e[5 q'
}

# Helps fix issues in some environments where cursor doesn't seem to be visible in
# vi-mode. Also helps keeps things consistent between vim and zsh with how cursor looks in
# insert vs vi modes.
precmd_functions+=(_fix_cursor)
