@REM copy settings to this repo

set HERE=%~dp0
set settingsDir=%HERE%\settings

@REM copy in vscode snippets
cd %HERE%
cp -r %appdata%\Code\User\snippets .

@REM copy in settings
cd %appdata%\Code\User
cp settings.json keybindings.json %settingsDir%

cd %HERE%