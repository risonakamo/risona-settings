# override settings on your system with the ones in this folder

set -ex
HERE=$(dirname $(realpath $BASH_SOURCE))
cd $HERE

cd settings
cp keybindings.json settings.json ~/.config/Code/User

cd $HERE/snippets
cp * ~/.config/Code/User/snippets