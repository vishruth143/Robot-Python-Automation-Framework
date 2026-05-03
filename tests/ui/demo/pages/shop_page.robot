*** Settings ***
Documentation    Page Object for the Demo Shop Page (rahulshettyacademy.com).
...
...              Contains all shop page locators and action/verification keywords.
...              Imported by test_demo.robot — never reference locators directly in tests.
Resource         ../resource.robot

*** Variables ***
# Shop page locators
${checkout_btn}     css:.nav-link
${card_titles}      css:.card-title a

*** Keywords ***
Verify Shop Page Is Loaded
    [Documentation]    Waits until the checkout navigation button is visible.
    Wait Until Element Is Visible    ${checkout_btn}    timeout=${DEFAULT_TIMEOUT}s

Verify Card Titles In The Shop Page
    [Documentation]    Asserts that the displayed card titles match the expected list exactly.
    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=         Get WebElements    ${card_titles}
    @{actual_list}=      Create List
    FOR    ${element}    IN    @{elements}
        Append To List    ${actual_list}    ${element.text}
    END
    Lists Should Be Equal    ${actual_list}    ${expected_list}

Select Card By Name
    [Documentation]    Finds the card matching ${CARD_NAME} (injected by config_loader.py) and clicks its Add button.
    ${elements}=    Get WebElements    ${card_titles}
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
