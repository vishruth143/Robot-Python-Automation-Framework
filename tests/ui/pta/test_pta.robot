*** Settings ***
Documentation    Validate the Practice Test Automation login page
...              https://practicetestautomation.com/practice-test-login/
Library          SeleniumLibrary
Test Setup       Open the browser with the login page practice url
Test Teardown    Close Browser Session
Resource         resource.robot

*** Test Cases ***
TC1 - Positive login with valid credentials
    Fill The Login Form    ${valid_user_name}    ${valid_password}
    Verify Successful Login

TC2 - Negative login with invalid username
    Fill The Login Form    ${invalid_user_name}    ${valid_password}
    Verify Error Message    Your username is invalid!

TC3 - Negative login with invalid password
    Fill The Login Form    ${valid_user_name}    ${invalid_password}
    Verify Error Message    Your password is invalid!

TC4 - Verify logout after successful login
    Fill The Login Form    ${valid_user_name}    ${valid_password}
    Verify Successful Login
    Click Element    ${logout_btn}
    Wait Until Element Is Visible    ${submit_btn}    timeout=10s

TC5 - Negative login with both fields empty
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${error_message_txt}    timeout=10s

*** Keywords ***
Fill The Login Form
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_field}    ${user_name}
    Input Password    ${password_field}    ${password}
    Click Element     ${submit_btn}

Verify Successful Login
    Wait Until Element Is Visible    ${success_heading}    timeout=10s
    Element Should Be Visible        ${success_message}
    Element Should Be Visible        ${logout_btn}
    Location Should Contain          logged-in-successfully

Verify Error Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${error_message_txt}    timeout=10s
    ${actual_msg}=    Get Text    ${error_message_txt}
    Should Be Equal As Strings    ${actual_msg}    ${expected_message}
