# failed auto setup
# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
############################################################################
# Set personnalised prompte
############################################################################
# Colors
NoColor="\033[0m"
Cyan="\033[0;36m"
Green="\033[0;32m"
Red="\033[0;31m"
BRed="\033[0;41m"
Yellow="\033[0;33m"
Magenta="\033[0;46m"

Gras="\033[0;01m"

# Chars
RootPrompt="\#"
NonRootPrompt="\$"

# Contextual prompt
prompt() {

        USERNAME=`whoami`
        HOSTNAME=`hostname -s`
#CURRENTPATH=`pwd | sed "s|$HOME|~|g"`

# Change the Window title
WINDOWTITLE="$USERNAME@$HOSTNAME"
echo -ne "\033]0;$WINDOWTITLE\007"

# Change the dynamic prompt
#LEFTPROMPT="$Yellow$CURRENTPATH"
LEFTPROMPT="\[$Yellow\]\w\n\[$Cyan\]$USERNAME@$HOSTNAME":"\[$Yellow\] [\t]"

GITSTATUS=$(git status 2> /dev/null)
if [ $? -eq 0 ]; then
        echo $GITSTATUS | grep "not staged" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
                LEFTPROMPT=$LEFTPROMPT"\[$Red\]"
        else
                LEFTPROMPT=$LEFTPROMPT"\[$Green\]"
        fi
         # BRANCH=`git describe --contains --all HEAD`
        BRANCH=`git rev-parse --abbrev-ref HEAD`
        LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
fi

if [ $EUID -ne 0 ]; then
        PS1=$LEFTPROMPT" \[$BRed\]"$NonRootPrompt"\[$NoColor\] "
else
        PS1=$LEFTPROMPT" \[$BRed\]"$RootPrompt"\[$NoColor\] "
fi

# echo -e -n $LEFTPROMPT
}

# Define PROMPT_COMMAND if not already defined (fix: Modifying title on SSH connections)
if [ -z "$PROMPT_COMMAND" ]; then
        case $TERM in
                xterm*)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
                screen)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
        esac
fi
   
# Main prompt
PROMPT_COMMAND="prompt;$PROMPT_COMMAND"

if [ $EUID -ne 0 ]; then
        PS1=$NonRootPrompt" "
else
        PS1=$RootPrompt" "
fi
############################################################################
alias reload='. ~/.bashrc'
alias vim='vi'

EDITOR=/usr/bin/vim

# make bash autocomplete with up arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

