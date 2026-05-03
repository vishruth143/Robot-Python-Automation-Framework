*** Settings ***
Documentation    Page Object for the Herokuapp Checkboxes Page.
...
...              Contains all checkboxes page locators and action/verification keywords.
...              Imported by test_heroku.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Checkboxes page locators
${checkbox_1}     css:form#checkboxes input:nth-of-type(1)
${checkbox_2}     css:form#checkboxes input:nth-of-type(2)

*** Keywords ***
Check Checkbox 1 And Verify Selected
    [Documentation]    Asserts checkbox 1 is unchecked, checks it, then verifies it is selected.
    Checkbox Should Not Be Selected    ${checkbox_1}
    Select Checkbox                    ${checkbox_1}
    Checkbox Should Be Selected        ${checkbox_1}

Uncheck Checkbox 2 And Verify Deselected
    [Documentation]    Asserts checkbox 2 is checked, unchecks it, then verifies it is deselected.
    Checkbox Should Be Selected        ${checkbox_2}
    Unselect Checkbox                  ${checkbox_2}
    Checkbox Should Not Be Selected    ${checkbox_2}
