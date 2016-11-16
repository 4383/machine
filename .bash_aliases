alias ll="ls -la"
alias dropbox="dropbox.py"
alias dev="cd ~/Dropbox/.dev"
alias activate="source ./bin/activate"
alias act="source ./bin/activate"
alias reload=". ~/.bashrc"

##########################
# create dir and go into
##########################
function mkcd(){
  mkdir $1 && cd $1
}
