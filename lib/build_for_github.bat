@echo off
echo Building for Web...

REM Set the base-href to your GitHub repository name (e.g. /dev_portal/).
REM Use "/" if you are using a custom domain.
call flutter build web --release --base-href "/dev_portal/"

echo Creating 404.html for GitHub Pages...
copy build\web\index.html build\web\404.html

echo Build complete! Upload the contents of build/web to GitHub Pages.
