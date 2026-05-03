*** Settings ***
Documentation    Page Object for the Herokuapp Add/Remove Elements Page.
...
...              Contains all add/remove page locators and action/verification keywords.
...              Imported by test_heroku.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Buttons ---
${add_element_btn}     css:button[onclick='addElement()']
${delete_btn}          css:button.added-manually

*** Keywords ***
Add Element And Verify Count
    [Documentation]    Clicks Add Element once and asserts exactly 1 delete button exists.
    Click Button                      ${add_element_btn}
    Wait Until Element Is Visible     ${delete_btn}    timeout=${DEFAULT_TIMEOUT}s
    ${count}=    Get Element Count    ${delete_btn}
    Should Be Equal As Integers       ${count}    1

Add Multiple Elements And Verify Count
    [Documentation]    Clicks Add Element the given number of times and verifies the count.
    [Arguments]    ${times}
    FOR    ${i}    IN RANGE    ${times}
        Click Button    ${add_element_btn}
    END
    ${count}=    Get Element Count    ${delete_btn}
    Should Be Equal As Integers       ${count}    ${times}

Add Element Then Delete And Verify Gone
    [Documentation]    Adds one element, deletes it, then asserts it is no longer visible.
    Click Button                      ${add_element_btn}
    Wait Until Element Is Visible     ${delete_btn}    timeout=${DEFAULT_TIMEOUT}s
    Click Button                      ${delete_btn}
    Element Should Not Be Visible     ${delete_btn}
