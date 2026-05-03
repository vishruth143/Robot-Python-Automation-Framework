*** Settings ***
Documentation    Page Object for the Herokuapp Login Page.
...
...              Contains all login page locators and action/verification keywords.
...              Imported by test_heroku.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Login page locators
${username_field}     id=username
${password_field}     id=password
${login_btn}          css:button[type='submit']
${flash_success}      css:#flash.success
${flash_error}        css:#flash.error
${logout_btn}         css:a[href='/logout']

*** Keywords ***
Login With
    [Documentation]    Enters credentials and submits the login form.
    [Arguments]    ${user_name}    ${password}
    Input Text        ${username_field}    ${user_name}
    Input Password    ${password_field}    ${password}
    Click Element     ${login_btn}

Verify Successful Login
    [Documentation]    Asserts the success flash message, logout button and URL after login.
    Wait Until Element Is Visible    ${flash_success}    timeout=${DEFAULT_TIMEOUT}s
    Element Text Should Contain      ${flash_success}    You logged into a secure area!
    Element Should Be Visible        ${logout_btn}
    Location Should Contain          /secure

Verify Login Error
    [Documentation]    Asserts an error flash message contains the expected text.
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${flash_error}    timeout=${DEFAULT_TIMEOUT}s
    Element Text Should Contain      ${flash_error}    ${expected_text}

Logout And Verify Redirected To Login
    [Documentation]    Clicks logout via href navigation and verifies redirect to /login.
    Wait Until Element Is Visible    ${logout_btn}    timeout=${DEFAULT_TIMEOUT}s
    ${href}=    Get Element Attribute    ${logout_btn}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${username_field}    timeout=${DEFAULT_TIMEOUT}s
    Location Should Contain          /login

Element Text Should Contain
    [Documentation]    Asserts that the text of an element contains the expected substring.
    [Arguments]    ${locator}    ${expected_text}
    ${actual}=    Get Text    ${locator}
    Should Contain    ${actual}    ${expected_text}
