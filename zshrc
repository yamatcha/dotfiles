#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
# goenv settings
# export GOENV_ROOT=$HOME/.goenv
# export PATH=$GOENV_ROOT/bin:$PATH
# eval "$(goenv init -)"

# go settings
export GOPATH=/Users/soju/go
export PATH=$GOPATH/bin:$PATH

## Set path for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

## powerline-go settings
function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# peco settings
function select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N select-history
bindkey '^r' select-history


# proxy setting
proxy=proxy.uec.ac.jp:8080
switch_trigger=uec

function set_proxy() {
  export http_proxy=$proxy
  export HTTP_PROXY=$proxy
  export ftp_proxy=$proxy
  export FTP_PROXY=$proxy
  export all_proxy=$proxy
  export ALL_PROXY=$proxy
  export https_proxy=$proxy
  export HTTPS_PROXY=$proxy

  git config --global http.proxy $proxy
  git config --global https.proxy $proxy
  git config --global url."https://".insteadOf git://
}

function unset_proxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset ftp_proxy
  unset FTP_PROXY
  unset all_proxy
  unset ALL_PROXY
  unset https_proxy
  unset HTTPS_PROXY

  git config --global --unset http.proxy
  git config --global --unset https.proxy
  git config --global --unset url."https://".insteadOf
}

if [ "`networksetup -getcurrentlocation`" = "$switch_trigger" ]; then
	echo "Switch to proxy for university network"
	set_proxy
else
	echo "Unset proxy"
	unset_proxy
fi


# alias setting

## cd
alias work='$HOME/workspace'

## global alias
alias -g @g='| grep'
alias -g @g='| less'

## SSH
alias sshk='ssh-keygen -t rsa'
alias vsc='vi ~/.ssh/config'

## Node
alias n='node index.js'

### npm
alias ni='npm install'
alias nu='npm uninstall'
alias nr='npm run'

### yarn
alias ya='yarn add'
alias yr='yarn remove'
alias yi='yarn install'

## git
alias gs='git status'
alias ga='git add'
alias gc-b='git checkout -b'
alias gc-m='git commit -m'
alias gp='git push'

## zsh
alias sz='source ~/.zshrc'
alias vimz='vim ~/.zshrc'
alias echopath='echo $PATH | perl -pe '\''s/:/\n/g'\'''

## docker
alias d='docker'
alias dc='docker-compose'
alias dcnt='docker container'
alias dcur='docker container ls -f status=running -l -q'
alias dexec='docker container exec -it $(dcur)'
alias dimg='docker images'
alias drun='docker container run —rm -d'
alias drunit='docker container run —rm -it'
alias dstop='docker container stop $(dcur)'
alias dimgrm='docker rmi `docker images | awk '\''NR>1{print $3}'\''` ' 
alias dcrm='docker rm -f `docker ps -a -q`'

# 補完
autoload -Uz compinit
compinit
# path settings 
typeset -U path PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/soju/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/soju/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/soju/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/soju/google-cloud-sdk/completion.zsh.inc'; fi
