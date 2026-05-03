@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=FALSE

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variablefile config/config_loader.py:demo:%REGION% --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% tests/ui/demo/
