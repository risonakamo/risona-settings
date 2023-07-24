# copy linux settings files to here

set -ex
HERE=$(dirname $(realpath $BASH_SOURCE))

cd ~
cp .bashrc .tmux.conf .zshrc .antigenrc $HERE