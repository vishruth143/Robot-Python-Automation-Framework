*** Settings ***
Documentation    Page Object for the Demo Login Page (rahulshettyacademy.com).
...
...              Contains all login page locators and action/verification keywords.
...              Imported by test_demo.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Login page locators
${username_field}              id=username
${password_field}              id=password
${terms_checkbox}              id=terms
${sign_in_btn}                 id=signInBtn
${login_error_message_txt}     css:.alert-danger

*** Keywords ***
Fill The Login Form
    [Documentation]    Enters credentials, accepts terms and clicks Sign In.
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_field}    ${user_name}
    Input Password    ${password_field}    ${password}
    Select Checkbox   ${terms_checkbox}
    Click Button      ${sign_in_btn}

Verify Login Error Message
    [Documentation]    Waits for the error alert and asserts its exact text.
    [Arguments]    ${expected_message}=Incorrect username/password.
    Wait Until Element Is Visible    ${login_error_message_txt}    timeout=${DEFAULT_TIMEOUT}s
    ${result}=    Get Text    ${login_error_message_txt}
    Should Be Equal As Strings    ${result}    ${expected_message}
