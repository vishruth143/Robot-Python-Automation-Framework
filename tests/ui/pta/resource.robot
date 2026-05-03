*** Settings ***
Documentation    Resource file for the Practice Test Automation (PTA) UI suite.
...
...              Environment URLs and test credentials are defined below as variables.
...              REGION (DEV/QA/STAGE/PROD) is set via the REGION env var or --variable,
...              defaulting to QA (inherited from common/common.robot).
...
...              Locators and page-level keywords live in pages/login_page.robot
...              and pages/dashboard_page.robot (Page Object Model).
...
...              Browser and headless mode are controlled via BROWSER and HEADLESS —
...              inherited from common/common.robot.
Resource         ../common/common.robot

*** Variables ***
# Environment URLs per region
&{PTA_URLS}
...    DEV=https://practicetestautomation.com/practice-test-login/
...    QA=https://practicetestautomation.com/practice-test-login/
...    STAGE=https://practicetestautomation.com/practice-test-login/
...    PROD=https://practicetestautomation.com/practice-test-login/

# Test credentials (can be overridden via --variable or environment variables)
${VALID_USERNAME}       %{VALID_USERNAME=student}
${VALID_PASSWORD}       %{VALID_PASSWORD=Password123}
${INVALID_USERNAME}     %{INVALID_USERNAME=incorrectUser}
${INVALID_PASSWORD}     %{INVALID_PASSWORD=incorrectPassword}

*** Keywords ***
Open the browser with the PTA website url
    [Documentation]    Resolves APP_URL from PTA_URLS using REGION, then opens the browser.
    ${APP_URL}=    Get From Dictionary    ${PTA_URLS}    ${REGION}
    Log    Running against → ${APP_URL}
    Open Browser For URL    ${APP_URL}
