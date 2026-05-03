*** Settings ***
Documentation    Resource file for the Practice Test Automation (PTA) UI suite.
...
...              Environment URLs are loaded from config/ui/pta/ui_test_env_config.yml
...              Test credentials are loaded from config/ui/pta/ui_test_data_config.yml
...              Both are injected via --variablefile config/config_loader.py:pta:<REGION>
...
...              Locators and page-level keywords live in pages/login_page.robot
...              and pages/dashboard_page.robot (Page Object Model).
...
...              Browser, headless mode and target environment are controlled via
...              BROWSER, HEADLESS and REGION — inherited from common/common.robot.
Resource         ../common/common.robot

*** Keywords ***
Open the browser with the PTA website url
    [Documentation]    Opens the browser using APP_URL injected by config_loader.py.
    Log    Running against → ${APP_URL}
    Open Browser For URL    ${APP_URL}
