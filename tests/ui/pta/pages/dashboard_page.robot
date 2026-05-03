*** Settings ***
Documentation    Page Object for the PTA Dashboard (Logged-In) Page.
...
...              Contains all dashboard page locators and action/verification keywords.
...              Imported by test_pta.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Headers ---
${success_heading_hdr}        //h1[contains(text(),'Logged In Successfully')]

# --- Labels ---
${success_message_lbl}        //strong[contains(text(),'Congratulations')]

# --- Links ---
${logout_lnk}                 //a[text()='Log out']

*** Keywords ***
Verify Successful Login
    [Documentation]    Asserts the dashboard page is displayed after a successful login.
    Wait Until Element Is Visible    ${success_heading_hdr}    timeout=${DEFAULT_TIMEOUT}s
    Element Should Be Visible        ${success_message_lbl}
    Element Should Be Visible        ${logout_lnk}
    Location Should Contain          logged-in-successfully

Click Logout Button
    [Documentation]    Clicks the Log out link on the dashboard page.
    Click Element    ${logout_lnk}
