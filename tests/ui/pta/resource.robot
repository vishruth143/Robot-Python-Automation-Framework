*** Settings ***
Documentation    Resource file for the Practice Test Automation (PTA) UI suite.
...
...              Contains suite-specific variables (APP_URLS, credentials, locators)
...              and the browser setup keyword for the PTA login page.
...
...              Browser, headless mode and target environment are controlled via
...              BROWSER, HEADLESS and REGION — inherited from common/common.robot.
Resource         ../common/common.robot

*** Variables ***

&{APP_URLS}
...    DEV=https://practicetestautomation.com/practice-test-login/
...    QA=https://practicetestautomation.com/practice-test-login/
...    STAGE=https://practicetestautomation.com/practice-test-login/
...    PROD=https://practicetestautomation.com/practice-test-login/

# Credentials
${valid_user_name}            student
${valid_password}             Password123
${invalid_user_name}          incorrectUser
${invalid_password}           incorrectPassword

# Login page locators
${username_field}             id=username
${password_field}             id=password
${submit_btn}                 //button[text()='Submit']
${error_message_txt}          id=error

# Logged-in page locators
${success_heading}            //h1[contains(text(),'Logged In Successfully')]
${success_message}            //strong[contains(text(),'Congratulations')]
${logout_btn}                 //a[text()='Log out']

*** Keywords ***
Open the browser with the PTA website url
    ${region_upper}=    Evaluate    '${REGION}'.upper()
    ${app_url}=         Get From Dictionary    ${APP_URLS}    ${region_upper}
    Log    Running against [${region_upper}] → ${app_url}
    Open Browser For URL    ${app_url}
