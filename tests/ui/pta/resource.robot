*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...              The system specific keywords created here form our own
...              Domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary
Library          SeleniumLibrary
Library          Collections
Resource         ../common/browser.robot

*** Variables ***
${REGION}     %{REGION=QA}
${BROWSER}    %{BROWSER=Chrome}
${HEADLESS}   %{HEADLESS=TRUE}

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
Open the browser with the login page practice url
    ${region_upper}=    Evaluate    '${REGION}'.upper()
    ${app_url}=         Get From Dictionary    ${APP_URLS}    ${region_upper}
    Log    Running against [${region_upper}] → ${app_url}
    Open Browser For URL    ${app_url}
