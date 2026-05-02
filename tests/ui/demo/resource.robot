*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...              The system specific keywords created here form our own
...              Domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary
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

${login_error_message_txt}    css:.alert-danger
${checkout_btn}               css:.nav-link
${card_titles}                css:.card-title a

*** Keywords ***
Open the browser with the login page practice url
    ${region_upper}=    Evaluate    '${REGION}'.upper()
    ${app_url}=         Get From Dictionary    ${APP_URLS}    ${region_upper}
    Log    Running against [${region_upper}] → ${app_url}
    Open Browser For URL    ${app_url}
