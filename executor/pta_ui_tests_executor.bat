@echo off
cd /d "%~dp0.."

set REGION=QA
set BROWSER=CHROME
set HEADLESS=TRUE

REM Credentials — set these env vars before running, or they fall back to defaults in resource.robot
REM set VALID_USERNAME=student
REM set VALID_PASSWORD=Password123
REM set INVALID_USERNAME=incorrectUser
REM set INVALID_PASSWORD=incorrectPassword

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output --variable BROWSER:%BROWSER% --variable HEADLESS:%HEADLESS% tests/ui/pta/
