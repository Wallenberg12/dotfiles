#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


## git
source ~/.bash-git-prompt/gitprompt.sh
alias gs="git status"
alias gl="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

## lazy
alias mp3="mplayer *.mp3"
alias n="nano"
alias nani="nano"

function search_in_bash_history () {
	grep "$1" ~/.bash_history
}
alias h="search_in_bash_history"

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
alias matlab="/home/markus/MATLAB/bin/matlab"
alias m="/home/markus/MATLAB/bin/matlab -nodesktop -nosplash"
alias o="octave-cli"

## lua
#export LUA_PATH='/home/markus/.luarocks/share/lua/5.1/?.lua;/home/markus/.luarocks/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;./?.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua'
#export LUA_CPATH='/home/markus/.luarocks/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;./?.so;/usr/lib/lua/5.1/loadall.so'

## local compiles
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.mlocal/lib"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.mlocal/bin" ] ; then
	export PATH="$HOME/.mlocal/bin:$HOME/.mlocal/usr/bin:$HOME/.mlocal/usr/local/bin:$PATH"
fi
 
if [ -d "$HOME/.mlocal/lib/pkgconfig" ]; then
	export PKG_CONFIG_PATH="$HOME/.mlocal/lib/pkgconfig"
fi

