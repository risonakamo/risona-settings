# --- profiler ---
# zmodload zsh/zprof


# --- antigen/zsh ---
. ~/.antigen.zsh
antigen init ~/.antigenrc
unsetopt share_history
unsetopt autopushd


# --- prompts ---
# ohmyzsh default prompt:
# export PROMPT="%(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
export PROMPT="%B%{$fg[green]%}%n@%M%{$reset_color%}%b:%B%{$fg[blue]%}%~%{$reset_color%}%b%# "


# --- env vars ---
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export GIT_SSL_NO_VERIFY=1
export NVM_DIR="$HOME/.nvm"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export DOCKER_BUILDKIT=1
export LD_LIBRARY_PATH=/usr/local/lib64
export dtcwc=dtcwcmin-n200


# --- aliases ---
alias startconda='eval "$(/home/mpiuser/soniccloud/ngokn1/anaconda/miniconda/bin/conda shell.bash hook)"'
alias startconda2='eval "$(/awlpool/awlcloud/ngokn1/conda/miniconda/bin/conda shell.bash hook)"'

alias gosoniccloud="pushd /home/mpiuser/soniccloud/ngokn1"
alias gofoxcloud="pushd /mnt/clouds/foxcloud/ngokn1"
alias golinkcloud="pushd /awlpool/awlcloud/ngokn1"

alias pip_install="pip install --default-timeout=100 --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.ngc.nvidia.com --trusted-host developer.download.nvidia.com"
alias pipinstalle="pip_install -e ."
alias sall="bash /awlpool/awlcloud/ngokn1/awl/awl-administration/utils/sshmultis/sall.sh"
alias gosall="cd /awlpool/awlcloud/ngokn1/awl/awl-administration/utils/sshmultis"

alias startnvm=". $NVM_DIR/nvm.sh && . $NVM_DIR/bash_completion"

alias dl="docker logs"

alias lt="ls -ltr"

alias runafsim="/awlpool/awlcloud/ngokn1/afsim25stuff/AFSIM-2.6.1-lnx64-gcc4/bin/mission"
alias runafsim2="/awlpool/awlcloud/ngokn1/afsim25stuff/AFSIM-2.9.0-lnx64-gcc4/bin/mission"

alias tp="trash-put"

# --- functions ---
# vscode the target folder and popd
# void codep(string 1:path)
codep()
{
    code $1 && popd
}

# drlog the first container that matches search string
# void drlog2(string 1:searchstring)
drlog2()
{
    command docker logs $(docker ps -a | grep $1 | head -1 | grep -Eo "^\S*")
}

# drlog the first container that matches search string with -f
# void drlog2f(string 1:searchstring)
drlog2f()
{
    command docker logs -f $(docker ps -a | grep $1 | head -1 | grep -Eo "^\S*")
}

# retag input docker image tag as latest and call docker push. need to give name and version seperately.
# void retaglatest(string dockerTag:1,string version:2)
retaglatest()
{
    docker tag $1:$2 $1:latest
    docker push $1:latest
}

# startconda2 and then activate target env
# void startconda2(string condaEnv:1)
lc2()
{
    eval "$(/awlpool/awlcloud/ngokn1/conda/miniconda/bin/conda shell.bash hook)"
    conda activate $1
}

# journalctl logs on service name
# $1: service name
jlogs()
{
    sudo journalctl --no-pager -n 500 -xefu $1.service
}
