@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=FALSE

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% --variable REGION:%REGION% tests/ui/demo/
