# The following lines were added by compinstall {{{1

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/bln/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install {{{1
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install



# ==========                      Variables                          ========== {{{1
# =============================================================================
# Common ENV variables
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export EDITOR="vim"
export DOCKER_APPS_BASE_PATH="$(realpath ~/Development/laptop/docker-apps)"
source ~/.aliases


# ==========                History search settings                 ========== {{{1
# =============================================================================
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "[A" up-line-or-beginning-search # Up
bindkey "[B" down-line-or-beginning-search # Down


# ==========                    Theme settings                      ========== {{{1
# =============================================================================
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs vi_mode)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='▓▒░'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='░▒▓'

source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
