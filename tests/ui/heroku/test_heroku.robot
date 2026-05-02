*** Settings ***
Documentation    Test suite for The Internet Herokuapp
...              https://the-internet.herokuapp.com/
Test Teardown    Close Browser Session
Resource         resource.robot

*** Test Cases ***
# ── Form Authentication ──────────────────────────────────────────────────────

TC1 - Successful login with valid credentials
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${valid_user_name}    ${valid_password}
    Wait Until Element Is Visible    ${flash_success}    timeout=10s
    Element Text Should Contain      ${flash_success}    You logged into a secure area!
    Element Should Be Visible        ${logout_btn}
    Location Should Contain          /secure

TC2 - Unsuccessful login with invalid username
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${invalid_user_name}    ${valid_password}
    Wait Until Element Is Visible    ${flash_error}    timeout=10s
    Element Text Should Contain      ${flash_error}    Your username is invalid!

TC3 - Unsuccessful login with invalid password
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${valid_user_name}    ${invalid_password}
    Wait Until Element Is Visible    ${flash_error}    timeout=10s
    Element Text Should Contain      ${flash_error}    Your password is invalid!

TC4 - Logout after successful login
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${valid_user_name}    ${valid_password}
    Wait Until Element Is Visible    ${logout_btn}    timeout=10s
    ${href}=    Get Element Attribute    ${logout_btn}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${username_field}    timeout=15s
    Location Should Contain          /login

# ── Checkboxes ───────────────────────────────────────────────────────────────

TC5 - Check checkbox 1 and verify it is selected
    [Setup]    Open Herokuapp Page    ${checkboxes_url}
    Checkbox Should Not Be Selected    ${checkbox_1}
    Select Checkbox                    ${checkbox_1}
    Checkbox Should Be Selected        ${checkbox_1}

TC6 - Uncheck checkbox 2 and verify it is deselected
    [Setup]    Open Herokuapp Page    ${checkboxes_url}
    Checkbox Should Be Selected        ${checkbox_2}
    Unselect Checkbox                  ${checkbox_2}
    Checkbox Should Not Be Selected    ${checkbox_2}

# ── Dropdown ─────────────────────────────────────────────────────────────────

TC7 - Select Option 1 from dropdown
    [Setup]    Open Herokuapp Page    ${dropdown_url}
    Select From List By Label         ${dropdown}    ${dropdown_option_1}
    ${selected}=    Get Selected List Label    ${dropdown}
    Should Be Equal As Strings        ${selected}    ${dropdown_option_1}

TC8 - Select Option 2 from dropdown
    [Setup]    Open Herokuapp Page    ${dropdown_url}
    Select From List By Label         ${dropdown}    ${dropdown_option_2}
    ${selected}=    Get Selected List Label    ${dropdown}
    Should Be Equal As Strings        ${selected}    ${dropdown_option_2}

# ── Add / Remove Elements ────────────────────────────────────────────────────

TC9 - Add an element and verify it appears
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Click Button                      ${add_element_btn}
    Wait Until Element Is Visible     ${delete_btn}    timeout=10s
    ${count}=    Get Element Count    ${delete_btn}
    Should Be Equal As Integers       ${count}    1

TC10 - Add multiple elements and verify count
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Click Button    ${add_element_btn}
    Click Button    ${add_element_btn}
    Click Button    ${add_element_btn}
    ${count}=    Get Element Count    ${delete_btn}
    Should Be Equal As Integers       ${count}    3

TC11 - Add then delete an element
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Click Button                      ${add_element_btn}
    Wait Until Element Is Visible     ${delete_btn}    timeout=10s
    Click Button                      ${delete_btn}
    Element Should Not Be Visible     ${delete_btn}

*** Keywords ***
Login With
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_field}    ${user_name}
    Input Password    ${password_field}    ${password}
    Click Element     ${login_btn}

Element Text Should Contain
    [Arguments]    ${locator}    ${expected_text}
    ${actual}=    Get Text    ${locator}
    Should Contain    ${actual}    ${expected_text}
