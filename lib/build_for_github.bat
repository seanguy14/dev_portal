@echo off
echo Building for Web...

REM IMPORTANT: Replace '/dev_portal/' with '/<your-repo-name>/' 
REM or just '/' if you are using a custom domain.
call flutter build web --release --base-href "/dev_portal/"

echo Creating 404.html for GitHub Pages...
copy build\web\index.html build\web\404.html

echo Build complete! Upload the contents of build/web to GitHub Pages.
