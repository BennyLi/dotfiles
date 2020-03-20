
##### ----- General configs {{{1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


##### ----- History settings {{{1
export HISTCONTROL=ignorespace,erasedups
export HISTSIZE=1000

##### ----- Export variables {{{1

export EDITOR=vim

##### ----- Prompt config {{{1
source ~/.bashrc_prompt


##### ----- Aliases {{{1
source ~/.aliases


##### ----- Completions {{{1
source /usr/share/bash-completion/completions/git
#source /usr/share/bash-completion/completions/man
