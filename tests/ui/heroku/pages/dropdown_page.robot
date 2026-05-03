*** Settings ***
Documentation    Page Object for the Herokuapp Dropdown Page.
...
...              Contains all dropdown page locators and action/verification keywords.
...              Imported by test_heroku.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Dropdowns ---
${options_ddl}            id=dropdown

# --- Test Data ---
${dropdown_option_1}      Option 1
${dropdown_option_2}      Option 2

*** Keywords ***
Select Dropdown Option And Verify
    [Documentation]    Selects a dropdown option by label and asserts it is selected.
    [Arguments]    ${option_label}
    Select From List By Label      ${options_ddl}    ${option_label}
    ${selected}=    Get Selected List Label    ${options_ddl}
    Should Be Equal As Strings     ${selected}    ${option_label}
