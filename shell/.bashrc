#! /usr/bin/env bash

#
# General setup
#
  # Disable history for the load time. Will be enabled and configured at the end.
  set +o history
  
  # Enable this for debugging
  # set -o xtrace

  # If not running interactively, don't do anything
  [[ $- != *i* ]] && return



#
# Export variables
#
  export EDITOR=vim


#
# Shell options
#   see https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#   see https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
#
  # Exit if a piped command failed
  set -o pipefail
  
  # Change directories without prepending 'cd'.
  shopt -s autocd

  # Handle window resizes better.
  shopt -s checkwinsize



#
# Job Control
#   see https://www.gnu.org/software/bash/manual/html_node/Job-Control.html
#
  # Enable Job Control 
  set -o monitor

  # Checks if background jobs are running before exiting the shell.
  shopt -s checkjobs



#
# (simple) spell auto-corrections
#
  shopt -s cdspell
  shopt -s dirspell



#
# Command expansion and pattern matching
#
  # Expand filename starting with a dot.
  shopt -s dotglob
  
  # Expand aliases.
  shopt -s expand_aliases
  
  # Extended pattern matching
  shopt -s extglob
  
  # Quotes in ${} allowed
  shopt -s extquote
  
  #shopt -s failglob
  
  # Ignore . and .. dirs on filename expansion.
  shopt -s globskipdots

  # Enable ** pattern matching
  shopt -s globstar
  
  # Only try to autocomplete if atleast one char has been entered.
  shopt -s no_empty_cmd_completion

  # Case-insensitiv pattern matching
  shopt -s nocaseglob

  # Enable programmable completion (like some argument completions)
  shopt -s progcomp
  shopt -s progcomp_alias



#
# Save yourself with not overriding files with >, >&, <>
#
  set -o noclobber



#
# Helper Functions
#

  init_ssh_agent() {
    env="${HOME}/.ssh/agent.env"

    agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
    agent_start () {
      (umask 077; ssh-agent >| "$env")
      . "$env" >| /dev/null
    }

    agent_load_env

    # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
    agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

    if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start
        ssh-add
    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
    fi

    unset env
  }

  init_command_line() {
    . "${HOME}/.bashrc_prompt"
  }

  extend_path_variable() {
    local dotfiles_path="$1"
    local paths_file="${dotfiles_path}/shell/.bashrc_path"

    [[ -f "$paths_file" ]] || return
    source "$paths_file"
  }

  init_aliases() {
    local dotfiles_path="$1"
    local aliases_file="${dotfiles_path}/shell/.aliases"

    [[ -f "$aliases_file" ]] || return
    source "$aliases_file"
  }

  setup_proxy() {
    echo "Setting up proxy config 🌐 ..."
    source ~/.bashrc_proxy
  }



#
# MAIN
#
  export PUBLIC_DOTFILES_REPO="${HOME}/.dotfiles"
  export DOTFILES_REPOS=( "${PUBLIC_DOTFILES_REPO}" "${HOME}/.dotfiles-tk" )

  for repo in ${DOTFILES_REPOS[@]}
  do
    extend_path_variable "$repo"
    setup_proxy "$repo"
    init_aliases "$repo"
    init_ssh_agent "$repo"
    init_command_line "$repo"
  done



#
# Autostart Apps
#



#
# History settings
#
  export HISTSIZE=100000
  export HISTFILESIZE=100000
  export HISTCONTROL=ignorespace:ignoredups:erasedups
  # Enable the command history
  set -o history
  # Do not override the history file on exit / start.
  shopt -s histappend
  # Enable ‘!’ style history substitution
  set -o histexpand
  # Save all lines of multiline commands
  shopt -s cmdhist
  # Write the history after every command
  export PROMPT_COMMAND="$PROMPT_COMMAND; history -a"





##### ----- Prompt config {{{1
source ~/.bashrc_prompt


##### ----- Aliases {{{1
source ~/.aliases


##### ----- Completions {{{1
source /usr/share/bash-completion/completions/git
#source /usr/share/bash-completion/completions/man
