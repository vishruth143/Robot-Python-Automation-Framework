*** Settings ***
Documentation    Page Object for the Demo Shop Page (rahulshettyacademy.com).
...
...              Contains all shop page locators and action/verification keywords.
...              Imported by test_demo.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# --- Links ---
${checkout_lnk}      css:.nav-link

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
    [Documentation]    Finds the card matching ${CARD_NAME} and clicks its Add button.
    ${elements}=    Get WebElements    ${card_titles_lbl}
    ${index}=       Set Variable    1
    FOR    ${element}    IN    @{elements}
        ${text}=      Evaluate    $element.text.strip().lower()
        ${target}=    Evaluate    '${CARD_NAME}'.strip().lower()
        IF    '${text}' == '${target}'
            BREAK
        END
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath=(//button[contains(text(),'Add')])[${index}]
