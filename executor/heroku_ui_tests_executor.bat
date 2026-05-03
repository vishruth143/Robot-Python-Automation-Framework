@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=TRUE

REM Credentials — set these env vars before running, or they fall back to defaults in resource.robot
REM set VALID_USERNAME=tomsmith
REM set VALID_PASSWORD=SuperSecretPassword!
REM set INVALID_USERNAME=wronguser
REM set INVALID_PASSWORD=wrongpassword

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% tests/ui/heroku/
