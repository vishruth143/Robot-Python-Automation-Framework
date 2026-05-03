*** Settings ***
Documentation    Validate the Practice Test Automation login page
...              https://practicetestautomation.com/practice-test-login/
Test Tags        PTA
Test Setup       Open the browser with the PTA website url
Test Teardown    Close Browser Session
Resource         resource.robot
Resource         pages/login_page.robot
Resource         pages/dashboard_page.robot

*** Test Cases ***
TC1 - Positive login with valid credentials
#    [Tags]    skip
    Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Successful Login

TC2 - Negative login with invalid username
#    [Tags]    skip
    Fill The Login Form    ${INVALID_USERNAME}    ${VALID_PASSWORD}
    Verify Error Message    Your username is invalid!

TC3 - Negative login with invalid password
#    [Tags]    skip
    Fill The Login Form    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Error Message    Your password is invalid!

TC4 - Verify logout after successful login
#    [Tags]    skip
    Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Successful Login
    Click Logout Button
    Verify Redirected To Login Page

TC5 - Negative login with both fields empty
#    [Tags]    skip
    Submit Empty Login Form
    Verify Error Message Is Visible
