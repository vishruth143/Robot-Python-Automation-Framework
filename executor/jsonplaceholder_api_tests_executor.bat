@echo off
cd /d "%~dp0.."

set REGION=QA

if exist output (
    echo Deleting existing output folder...
    rmdir /s /q output
)

robot -d output tests/api/jsonplaceholder/

