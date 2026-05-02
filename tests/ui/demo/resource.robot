*** Settings ***
Documentation    Resource file for the Demo UI suite (rahulshettyacademy.com).
...
...              Contains suite-specific variables (APP_URLS, credentials, locators)
...              and the browser setup keyword for the login page practice site.
...              Covers: Login validation, Shopping cart card verification.
...
...              Browser, headless mode and target environment are controlled via
...              BROWSER, HEADLESS and REGION — inherited from common/browser.robot.
Resource         ../common/browser.robot

*** Variables ***
&{APP_URLS}
...    DEV=https://dev.rahulshettyacademy.com/loginpagePractise
...    QA=https://rahulshettyacademy.com/loginpagePractise
...    STAGE=https://stage.rahulshettyacademy.com/loginpagePractise
...    PROD=https://rahulshettyacademy.com/loginpagePractise

${valid_user_name}            rahulshettyacademy
${valid_password}             Learning@830$3mK2
${invalid_user_name}          test
${invalid_password}           test
${card_name}                  iphone X

${login_error_message_txt}    css:.alert-danger
${checkout_btn}               css:.nav-link
${card_titles}                css:.card-title a

*** Keywords ***
Open the browser with the login page practice url
    ${region_upper}=    Evaluate    '${REGION}'.upper()
    ${app_url}=         Get From Dictionary    ${APP_URLS}    ${region_upper}
    Log    Running against [${region_upper}] → ${app_url}
    Open Browser For URL    ${app_url}
