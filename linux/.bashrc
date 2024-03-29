# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- own stuff ---
# export PYTHONPATH=.:..:/home/ngokn1/mounts/cloud/aiarena:/home/ngokn1/mounts/cloud/airtest/airair2:/home/mpiuser/cloud/ngokn2/adttest
#:/home/mpiuser/cloud/ngokn2/airtest3
export TERM=xterm-256color
export PATH=$PATH:/mnt/clouds/foxcloud/ngokn1/cloudstuff/google-cloud-sdk/bin
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export GIT_SSL_NO_VERIFY=1

# alias mpikyle="/home/casteka1/share/awlShare/airs/conda/anaconda3/envs/mpiEnv/bin/mpiexec --prefix /home/casteka1/share/awlShare/airs/conda/anaconda3/envs/mpiEnv --mca btl_tcp_if_include enp4s0"
# alias kyleconda='eval "$(/home/casteka1/share/awlShare/airs/conda/anaconda3/bin/conda shell.bash hook)"'
alias startconda='eval "$(/home/mpiuser/soniccloud/ngokn1/anaconda/miniconda/bin/conda shell.bash hook)"'
alias startconda2='eval "$(/awlpool/awlcloud/ngokn1/conda/miniconda/bin/conda shell.bash hook)"'
# alias mpiair="/home/mpiuser/cloud/ngokn2/conda/anaconda/envs/airenv/bin/mpiexec --prefix /home/mpiuser/cloud/ngokn2/conda/anaconda/envs/airenv --mca btl_tcp_if_include enp4s0"
# alias mpiair2="/home/mpiuser/cloud/ngokn2/conda/anaconda/envs/airenv2/bin/mpiexec --prefix /home/mpiuser/cloud/ngokn2/conda/anaconda/envs/airenv2 --mca btl_tcp_if_include enp4s0"

alias killowncontainers='docker kill $(docker ps -f label=creator=$USER -q)'
alias drimg='docker run -it $(docker images -a -q | sed -n "1p") bash' #run last created image (for when editing/building docker images)
alias drlog='docker logs $(docker ps -a -q | sed -n "1p")' #logs of last container

alias gosoniccloud="pushd /home/mpiuser/soniccloud/ngokn1"
alias gofoxcloud="pushd /mnt/clouds/foxcloud/ngokn1"
alias golinkcloud="pushd /awlpool/awlcloud/ngokn1"

alias ducur="du -h -d 1 | sort -hr" #du current dir and sort by size
alias cdp="cd -P"

alias pip_install="pip install --default-timeout=100 --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.ngc.nvidia.com --trusted-host developer.download.nvidia.com"

alias runafsim="/awlpool/awlcloud/ngokn1/afsim25stuff/AFSIM-2.6.1-lnx64-gcc4/bin/mission"

#alias thing="mpiawl -n 3 --oversubscribe -x PYTHONPATH=$PYTHONPATH --host fox,sonic python my_main_script.py"

# vscode the target folder and popd
# void codep(1:string path)
codep()
{
    code $1 && popd
}

# drlog the first container that matches search string
drlog2()
{
    command docker logs $(docker ps -a | grep $1 | head -1 | grep -Eo "^\S*")
}

# drlog the first container that matches search string with -f
drlog2f()
{
    command docker logs -f $(docker ps -a | grep $1 | head -1 | grep -Eo "^\S*")
}

# $1: namespace to force kill all pods in
kube_purge_namespace()
{
    kubectl -n $1 delete pods --all --force --grace-period=0
}
# --- end own stuff ---

# --- added by installers ---
#source "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# --- endadded by installers ---
. "$HOME/.cargo/env"
