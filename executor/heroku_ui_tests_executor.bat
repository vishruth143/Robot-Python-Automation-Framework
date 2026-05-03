@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=TRUE

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variablefile config/config_loader.py:heroku:%REGION% --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% tests/ui/heroku/
