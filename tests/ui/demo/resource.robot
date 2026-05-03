*** Settings ***
Documentation    Resource file for the Demo UI suite (rahulshettyacademy.com).
...
...              Environment URLs and test credentials are defined below as variables.
...              REGION (DEV/QA/STAGE/PROD) is set via the REGION env var or --variable,
...              defaulting to QA (inherited from common/common.robot).
...
...              Locators and page-level keywords live in pages/login_page.robot
...              and pages/shop_page.robot (Page Object Model).
...
...              Browser and headless mode are controlled via BROWSER and HEADLESS —
...              inherited from common/common.robot.
Resource         ../common/common.robot

*** Variables ***
# =============================================================================
# Environment Config
# =============================================================================

# Environment URLs per region
&{DEMO_URLS}
...    DEV=https://dev.rahulshettyacademy.com/loginpagePractise
...    QA=https://rahulshettyacademy.com/loginpagePractise
...    STAGE=https://stage.rahulshettyacademy.com/loginpagePractise
...    PROD=https://rahulshettyacademy.com/loginpagePractise

# =============================================================================
# Test Data
# =============================================================================

# Test credentials (can be overridden via --variable or environment variables)
${VALID_USERNAME}       %{VALID_USERNAME=rahulshettyacademy}
${VALID_PASSWORD}       %{VALID_PASSWORD=Learning@830$3mK2}
${INVALID_USERNAME}     %{INVALID_USERNAME=test}
${INVALID_PASSWORD}     %{INVALID_PASSWORD=test}

*** Keywords ***
Open the browser with the login page practice url
    [Documentation]    Resolves APP_URL from DEMO_URLS using REGION, then opens the browser.
    ${APP_URL}=    Get From Dictionary    ${DEMO_URLS}    ${REGION}
    Log    Running against → ${APP_URL}
    Open Browser For URL    ${APP_URL}
