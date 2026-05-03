*** Settings ***
Documentation    Test suite for The Internet Herokuapp
...              https://the-internet.herokuapp.com/
Test Tags        HEROKU
Test Teardown    Close Browser Session
Resource         resource.robot
Resource         pages/login_page.robot
Resource         pages/checkboxes_page.robot
Resource         pages/dropdown_page.robot
Resource         pages/add_remove_page.robot

*** Test Cases ***
# ── Form Authentication ──────────────────────────────────────────────────────

TC1 - Successful login with valid credentials
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Successful Login

TC2 - Unsuccessful login with invalid username
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${INVALID_USERNAME}    ${VALID_PASSWORD}
    Verify Login Error    Your username is invalid!

TC3 - Unsuccessful login with invalid password
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Error    Your password is invalid!

TC4 - Logout after successful login
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${login_url}
    Login With    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Logout And Verify Redirected To Login

# ── Checkboxes ───────────────────────────────────────────────────────────────

TC5 - Check checkbox 1 and verify it is selected
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${checkboxes_url}
    Check Checkbox 1 And Verify Selected

TC6 - Uncheck checkbox 2 and verify it is deselected
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${checkboxes_url}
    Uncheck Checkbox 2 And Verify Deselected

# ── Dropdown ─────────────────────────────────────────────────────────────────

TC7 - Select Option 1 from dropdown
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${dropdown_url}
    Select Dropdown Option And Verify    ${dropdown_option_1}

TC8 - Select Option 2 from dropdown
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${dropdown_url}
    Select Dropdown Option And Verify    ${dropdown_option_2}

# ── Add / Remove Elements ────────────────────────────────────────────────────

TC9 - Add an element and verify it appears
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Add Element And Verify Count

TC10 - Add multiple elements and verify count
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Add Multiple Elements And Verify Count    3

TC11 - Add then delete an element
#    [Tags]    skip
    [Setup]    Open Herokuapp Page    ${add_remove_url}
    Add Element Then Delete And Verify Gone
