# copy linux settings files to here

set -ex
HERE=$(dirname $(realpath $BASH_SOURCE))

cd $HERE
cp .bashrc .tmux.conf .zshrc .antigenrc ~