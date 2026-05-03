*** Settings ***
Documentation    Validate the login form and shopping page (rahulshettyacademy.com)
Test Tags        DEMO
Test Setup       Open the browser with the login page practice url
Test Teardown    Close Browser Session
Resource         resource.robot
Resource         pages/login_page.robot
Resource         pages/shop_page.robot

*** Test Cases ***
TC1 - Validate un-successful login
#    [Tags]    skip
    Fill The Login Form    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Error Message

TC2 - Validate cards display in the shopping page
#    [Tags]    skip
    Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Shop Page Is Loaded
    Verify Card Titles In The Shop Page

TC3 - Select the card by name
#    [Tags]    skip
    Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Shop Page Is Loaded
    @{cards}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    FOR    ${card}    IN    @{cards}
        Select Card By Name    ${card}
    END
    Verify Checkout Count    4
