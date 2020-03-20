
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Reset the cursor to the default block before starting any progam
PS0="\e[2 q"
PS1='[\u@\h \W]\$ '


# Add my alias config
source ~/.aliases
