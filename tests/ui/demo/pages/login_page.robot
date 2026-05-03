*** Settings ***
Documentation    Page Object for the Demo Login Page (rahulshettyacademy.com).
...
...              Contains all login page locators and action/verification keywords.
...              Imported by test_demo.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Text Fields ---
${username_txt}              id=username
${password_pwd}              id=password

# --- Checkboxes ---
${terms_chk}                 id=terms

# --- Buttons ---
${sign_in_btn}               id=signInBtn

# --- Labels ---
${login_error_lbl}           css:.alert-danger

*** Keywords ***
Fill The Login Form
    [Documentation]    Enters credentials, accepts terms and clicks Sign In.
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_txt}    ${user_name}
    Input Password    ${password_pwd}    ${password}
    Select Checkbox   ${terms_chk}
    Click Button      ${sign_in_btn}

Verify Login Error Message
    [Documentation]    Waits for the error alert and asserts its exact text.
    [Arguments]    ${expected_message}=Incorrect username/password.
    Wait Until Element Is Visible    ${login_error_lbl}    timeout=${DEFAULT_TIMEOUT}s
    ${result}=    Get Text    ${login_error_lbl}
    Should Be Equal As Strings    ${result}    ${expected_message}
