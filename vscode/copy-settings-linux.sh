# copy settings to here

set -exu
HERE=$(dirname $(realpath $BASH_SOURCE))
cd $HERE

settingsDir=$HERE/settings

cd ~/.config/Code/User
cp settings.json keybindings.json $settingsDir
cp -r ~/.config/Code/User/snippets/* $HERE/snippets