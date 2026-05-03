*** Settings ***
Documentation    Resource file for The Internet Herokuapp UI suite.
...              https://the-internet.herokuapp.com/
...
...              Environment URLs are loaded from config/ui/heroku/ui_test_env_config.yml
...              Test credentials are loaded from config/ui/heroku/ui_test_data_config.yml
...              Both are injected via --variablefile config/config_loader.py:heroku:<REGION>
...
...              Locators and page-level keywords live in pages/:
...                - pages/login_page.robot
...                - pages/checkboxes_page.robot
...                - pages/dropdown_page.robot
...                - pages/add_remove_page.robot
...              (Page Object Model)
...
...              Browser, headless mode and target environment are controlled via
...              BROWSER, HEADLESS and REGION — inherited from common/common.robot.
Resource         ../common/common.robot

*** Variables ***
# URL paths — these are structural, not data, so they stay here
${login_url}              /login
${checkboxes_url}         /checkboxes
${dropdown_url}           /dropdown
${add_remove_url}         /add_remove_elements/

*** Keywords ***
Open Herokuapp Page
    [Documentation]    Opens the browser using APP_URL injected by config_loader.py, appending ${path}.
    [Arguments]    ${path}
    Log    Running against → ${APP_URL}${path}
    Open Browser For URL    ${APP_URL}${path}
