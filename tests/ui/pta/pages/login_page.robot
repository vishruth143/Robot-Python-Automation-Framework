*** Settings ***
Documentation    Page Object for the PTA Login Page.
...
...              Contains all login page locators and action/verification keywords.
...              Imported by test_pta.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Login page locators
${username_field}             id=username
${password_field}             id=password
${submit_btn}                 //button[text()='Submit']
${error_message_txt}          id=error

*** Keywords ***
Fill The Login Form
    [Documentation]    Enters credentials and clicks Submit.
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_field}    ${user_name}
    Input Password    ${password_field}    ${password}
    Click Element     ${submit_btn}

Submit Empty Login Form
    [Documentation]    Clicks Submit without entering any credentials.
    Click Element    ${submit_btn}

Verify Error Message
    [Documentation]    Waits for the error message and asserts its text.
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${error_message_txt}    timeout=${DEFAULT_TIMEOUT}s
    ${actual_msg}=    Get Text    ${error_message_txt}
    Should Be Equal As Strings    ${actual_msg}    ${expected_message}

Verify Error Message Is Visible
    [Documentation]    Waits for the error message element to be visible (without asserting text).
    Wait Until Element Is Visible    ${error_message_txt}    timeout=${DEFAULT_TIMEOUT}s
