*** Settings ***
Documentation    Resource file for The Internet Herokuapp UI suite.
...              https://the-internet.herokuapp.com/
...
...              Environment URLs and test credentials are defined below as variables.
...              REGION (DEV/QA/STAGE/PROD) is set via the REGION env var or --variable,
...              defaulting to QA (inherited from common/common.robot).
...
...              Locators and page-level keywords live in pages/:
...                - pages/login_page.robot
...                - pages/checkboxes_page.robot
...                - pages/dropdown_page.robot
...                - pages/add_remove_page.robot
...              (Page Object Model)
...
...              Browser and headless mode are controlled via BROWSER and HEADLESS —
...              inherited from common/common.robot.
Resource         ../common/common.robot

*** Variables ***
# Environment URLs per region
&{HEROKU_URLS}
...    DEV=https://the-internet.herokuapp.com
...    QA=https://the-internet.herokuapp.com
...    STAGE=https://the-internet.herokuapp.com
...    PROD=https://the-internet.herokuapp.com

# Test credentials (can be overridden via --variable or environment variables)
${VALID_USERNAME}       %{VALID_USERNAME=tomsmith}
${VALID_PASSWORD}       %{VALID_PASSWORD=SuperSecretPassword!}
${INVALID_USERNAME}     %{INVALID_USERNAME=wronguser}
${INVALID_PASSWORD}     %{INVALID_PASSWORD=wrongpassword}

# URL paths — structural, not data
${login_url}              /login
${checkboxes_url}         /checkboxes
${dropdown_url}           /dropdown
${add_remove_url}         /add_remove_elements/

*** Keywords ***
Open Herokuapp Page
    [Documentation]    Resolves APP_URL from HEROKU_URLS using REGION, then opens the browser at ${path}.
    [Arguments]    ${path}
    ${APP_URL}=    Get From Dictionary    ${HEROKU_URLS}    ${REGION}
    Log    Running against → ${APP_URL}${path}
    Open Browser For URL    ${APP_URL}${path}
