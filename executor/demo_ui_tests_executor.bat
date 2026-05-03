@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=FALSE

REM Credentials — set these env vars before running, or they fall back to defaults in resource.robot
REM set VALID_USERNAME=rahulshettyacademy
REM set VALID_PASSWORD=Learning@830$3mK2
REM set INVALID_USERNAME=test
REM set INVALID_PASSWORD=test

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% tests/ui/demo/
