# --- profiler ---
# zmodload zsh/zprof


# --- antigen ---
. ~/.antigen.zsh
antigen init ~/.antigenrc


# --- prompts ---
# ohmyzsh default prompt:
# export PROMPT="%(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
export PROMPT="%B%{$fg[green]%}%n@%M%{$reset_color%}%b:%B%{$fg[blue]%}%~%{$reset_color%}%b%# "


# --- env vars ---
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export GIT_SSL_NO_VERIFY=1
export NVM_DIR="$HOME/.nvm"


# --- aliases ---
alias startconda='eval "$(/home/mpiuser/soniccloud/ngokn1/anaconda/miniconda/bin/conda shell.bash hook)"'
alias startconda2='eval "$(/awlpool/awlcloud/ngokn1/conda/miniconda/bin/conda shell.bash hook)"'

alias gosoniccloud="pushd /home/mpiuser/soniccloud/ngokn1"
alias gofoxcloud="pushd /mnt/clouds/foxcloud/ngokn1"
alias golinkcloud="pushd /awlpool/awlcloud/ngokn1"

alias pip_install="pip install --default-timeout=100 --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.ngc.nvidia.com --trusted-host developer.download.nvidia.com"

alias startnvm=". $NVM_DIR/nvm.sh && . $NVM_DIR/bash_completion"

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