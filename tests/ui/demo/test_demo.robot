*** Settings ***
Documentation    Validate the login form
Test Setup       Open the browser with the login page practice url
Test Teardown    Close Browser Session
Resource    resource.robot

*** Test Cases ***
TC1 - Validate un-successful login
    Fill The Login Form    ${invalid_user_name}    ${invalid_password}
    Wait Until Element Is Visible    ${login_error_message_txt}    timeout=10s
    Verify Error Message Is Correct

TC2 - Validate cards display in the shopping page
    Fill The Login Form    ${valid_user_name}    ${valid_password}
    Wait Until Element Is Visible    ${checkout_btn}    timeout=10s
    Verify card titles in the shop page

*** Keywords ***
Fill The Login Form
    [Arguments]    ${user_name}    ${password}
    Input Text        id=username    ${user_name}
    Input Password    id=password    ${password}
    Select Checkbox   id=terms
    Click Button      id=signInBtn

Verify Error Message Is Correct
    ${result}=    Get Text    ${login_error_message_txt}
    Should Be Equal As Strings    ${result}    Incorrect username/password.

Verify card titles in the shop page
    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=    Get WebElements    ${card_titles}
    @{actual_list}=    Create List

    FOR    ${element}    IN    @{elements}
        Append To List    ${actual_list}    ${element.text}
    END
    Lists Should Be Equal    ${actual_list}    ${expected_list}
