@REM copy settings to this repo

set HERE=%~dp0
set settingsDir=%HERE%\settings

cd %appdata%\Code\User
cp settings.json keybindings.json %HERE%

cd %HERE%