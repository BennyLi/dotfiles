
##### ----- General configs {{{1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


##### ----- Prompt config {{{1

# Reset the cursor to the default block before starting any progam
PS0="\e[2 q"
PS1='[\u@\h \W]\$ '


##### ----- Aliases {{{1
source ~/.aliases


##### ----- Completions {{{1
source /usr/share/bash-completion/completions/git
