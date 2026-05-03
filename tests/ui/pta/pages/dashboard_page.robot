*** Settings ***
Documentation    Page Object for the PTA Dashboard (Logged-In) Page.
...
...              Contains all dashboard page locators and action/verification keywords.
...              Imported by test_pta.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Logged-in page locators
${success_heading}            //h1[contains(text(),'Logged In Successfully')]
${success_message}            //strong[contains(text(),'Congratulations')]
${logout_btn}                 //a[text()='Log out']

*** Keywords ***
Verify Successful Login
    [Documentation]    Asserts the dashboard page is displayed after a successful login.
    Wait Until Element Is Visible    ${success_heading}    timeout=${DEFAULT_TIMEOUT}s
    Element Should Be Visible        ${success_message}
    Element Should Be Visible        ${logout_btn}
    Location Should Contain          logged-in-successfully

Click Logout Button
    [Documentation]    Clicks the Log out link on the dashboard page.
    Click Element    ${logout_btn}
