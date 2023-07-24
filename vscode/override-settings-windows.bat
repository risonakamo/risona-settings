@REM THIS WILL OVERRIDE YOUR SETTINGS!!!

set HERE=%~dp0
set settingsDir=%HERE%\settings

cd %HERE%
cp -r snippets %appdata%\Code\User

cd %HERE%\settings
cp *.json %appdata%\Code\User

cd %HERE%