*** Settings ***
Documentation    Page Object for the Demo Shop Page (rahulshettyacademy.com).
...
...              Contains all shop page locators and action/verification keywords.
...              Imported by test_demo.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Links ---
${checkout_lnk}      css:a.nav-link.btn-primary

# --- Labels ---
${card_titles_lbl}   css:.card-title a

*** Keywords ***
Verify Shop Page Is Loaded
    [Documentation]    Waits until the checkout navigation button is visible.
    Wait Until Element Is Visible    ${checkout_lnk}    timeout=${DEFAULT_TIMEOUT}s

Verify Card Titles In The Shop Page
    [Documentation]    Asserts that the displayed card titles match the expected list exactly.
    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=         Get WebElements    ${card_titles_lbl}
    @{actual_list}=      Create List
    FOR    ${element}    IN    @{elements}
        Append To List    ${actual_list}    ${element.text}
    END
    Lists Should Be Equal    ${actual_list}    ${expected_list}

Select Card By Name
    [Documentation]    Finds the card matching the given name and clicks its Add button.
    [Arguments]    ${card_name}
    ${elements}=    Get WebElements    ${card_titles_lbl}
    ${index}=       Set Variable    1
    FOR    ${element}    IN    @{elements}
        ${text}=      Evaluate    $element.text.strip().lower()
        ${target}=    Evaluate    '${card_name}'.strip().lower()
        IF    '${text}' == '${target}'
            BREAK
        END
        ${index}=    Evaluate    ${index} + 1
    END
    ${btn}=    Get WebElement    xpath=(//button[contains(text(),'Add')])[${index}]
    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${btn}
    Sleep    1s

Verify Checkout Count
    [Documentation]    Asserts the checkout button displays the expected item count.
    [Arguments]    ${expected_count}
    ${text}=    Get Text    ${checkout_lnk}
    Should Contain    ${text}    Checkout ( ${expected_count} )
