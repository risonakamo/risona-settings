# vs code settings
vscode settings sync procedure

1. clean up your local settings file by moving all the theme settings into `editorcustomisations.jsonc`
2. override the settings.json/keybindings in this repo with your own
3. review the changes to see if the override is good or not. adjust as needed
4. make commit
5. override your original settings/keybinds with this one. if you made no changes, then don't need to override

# extensions
## how to use
the extensions.json file in vscodeextensionsexport is the full extensions file. by putting it into a .vscode you can install from the list using the recomended extensions panel.

## how to sync
just run `npm run run` in the vscodeextensionsexport folder. it will target your vscode and add any new extensions to the extensions file. **just have to make sure the script is pointing to the right vscode location**