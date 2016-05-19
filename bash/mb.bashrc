#
# ~/.bashrc
#

## git
######
source ~/.bash-git-prompt/gitprompt.sh
alias gs="git status"
alias gl="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

## ssh keygen
#############
alias newpubkey='ssh-keygen -f ~/.ssh/id_rsa -y'
alias fingerprint='ssh-keygen -lf ~/.ssh/id_rsa.pub'

## lazy
#######
alias mp3="mplayer *.mp3"
alias n="nano"
alias nani="nano"

function search_in_bash_history () {
	grep "$1" ~/.bash_history
}
alias h="search_in_bash_history"

## lua
######
function lua_environment () {
	if (("$#" == 1)); then
		if [ $1 == "51" ]; then
			eval $(luarocks-5.1 path)
		elif [ $1 == "52" ]; then
			eval $(luarocks-5.2 path)
		elif [ $1 == "53" ]; then
			eval $(luarocks-5.3 path)
		fi
	fi
}
alias uselua="lua_environment"

## matlab/octave
################
alias matlab="/home/markus/MATLAB/bin/matlab"
alias m="/home/markus/MATLAB/bin/matlab -nodesktop -nosplash"
alias o="octave-cli"


## local compiles
#################
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.mlocal/lib"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.mlocal/bin" ] ; then
	export PATH="$HOME/.mlocal/bin:$HOME/.mlocal/usr/bin:$HOME/.mlocal/usr/local/bin:$PATH"
fi
 
if [ -d "$HOME/.mlocal/lib/pkgconfig" ]; then
	export PKG_CONFIG_PATH="$HOME/.mlocal/lib/pkgconfig"
fi

if [ $(uname) = "NetBSD" ]; then
	PKG_PATH="http://ftp.netbsd.org/pub/pkgsrc/packages/NetBSD/x86_64/7.0/All/"
	export PKG_PATH
fi