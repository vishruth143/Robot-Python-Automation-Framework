*** Settings ***
Documentation    Resource file for The Internet Herokuapp UI suite.
...              https://the-internet.herokuapp.com/
...
...              Contains suite-specific variables (APP_URLS, credentials, locators)
...              and the browser setup keyword for the Herokuapp pages.
...              Covers: Form Authentication, Checkboxes, Dropdown, Add/Remove Elements.
...
...              Browser, headless mode and target environment are controlled via
...              BROWSER, HEADLESS and REGION — inherited from common/browser.robot.
Resource         ../common/browser.robot

*** Variables ***
&{APP_URLS}
...    DEV=https://the-internet.herokuapp.com
...    QA=https://the-internet.herokuapp.com
...    STAGE=https://the-internet.herokuapp.com
...    PROD=https://the-internet.herokuapp.com

# --- Form Authentication ---
${login_url}              /login
${username_field}         id=username
${password_field}         id=password
${login_btn}              css:button[type='submit']
${flash_success}          css:#flash.success
${flash_error}            css:#flash.error
${logout_btn}             css:a[href='/logout']

${valid_user_name}        tomsmith
${valid_password}         SuperSecretPassword!
${invalid_user_name}      wronguser
${invalid_password}       wrongpassword

# --- Checkboxes ---
${checkboxes_url}         /checkboxes
${checkbox_1}             css:form#checkboxes input:nth-of-type(1)
${checkbox_2}             css:form#checkboxes input:nth-of-type(2)

# --- Dropdown ---
${dropdown_url}           /dropdown
${dropdown}               id=dropdown
${dropdown_option_1}      Option 1
${dropdown_option_2}      Option 2

# --- Add / Remove Elements ---
${add_remove_url}         /add_remove_elements/
${add_element_btn}        css:button[onclick='addElement()']
${delete_btn}             css:button.added-manually

*** Keywords ***
Open Herokuapp Page
    [Arguments]    ${path}
    ${region_upper}=    Evaluate    '${REGION}'.upper()
    ${base_url}=        Get From Dictionary    ${APP_URLS}    ${region_upper}
    Log    Running against [${region_upper}] → ${base_url}${path}
    Open Browser For URL    ${base_url}${path}
