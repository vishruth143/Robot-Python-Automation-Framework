*** Settings ***
Documentation    Shared browser launch, teardown keywords, and common variables.
...
...              Supports Chrome, Edge and Firefox in both headless
...              and headful modes, driven by the BROWSER and HEADLESS
...              variables (defaults: Chrome / TRUE).
...
...              REGION controls the target environment (DEV, QA, STAGE, PROD).
...              Defaults to QA.
...
...              Chrome flags applied:
...                --headless=new          (headless mode only)
...                --no-sandbox            (required in Docker/CI containers)
...                --disable-dev-shm-usage (prevents /dev/shm OOM crashes)
...                --window-size=1920,1080 (always, for consistent resolution)
...
...              SeleniumLibrary is imported here with screenshot_root_directory=EMBED
...              so that a screenshot is automatically captured and embedded into
...              log.html on any test failure — no extra keywords needed.
Library          SeleniumLibrary    run_on_failure=Capture Page Screenshot    screenshot_root_directory=EMBED
Library          Collections

*** Variables ***
${REGION}              %{REGION=QA}
${BROWSER}             %{BROWSER=CHROME}
${HEADLESS}            %{HEADLESS=FALSE}
${DEFAULT_TIMEOUT}     10

*** Keywords ***
Open Browser For URL
    [Documentation]    Launch the configured browser and navigate to ${url}.
    [Arguments]    ${url}
    ${browser_lower}=    Evaluate    '${BROWSER}'.lower()
    IF    '${browser_lower}' == 'chrome'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
        # Always-on flags — required in CI/Docker containers
        Evaluate    $options.add_argument('--no-sandbox')    sys
        Evaluate    $options.add_argument('--disable-dev-shm-usage')    sys
        Evaluate    $options.add_argument('--disable-gpu')    sys
        Evaluate    $options.add_argument('--window-size=1920,1080')    sys
        # Headless-only flag
        IF    '${HEADLESS}' == 'TRUE'
            Evaluate    $options.add_argument('--headless=new')    sys
        END
        Open Browser    ${url}    Chrome    options=${options}
    ELSE IF    '${browser_lower}' == 'edge'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys
        Evaluate    $options.add_argument('--no-sandbox')    sys
        Evaluate    $options.add_argument('--disable-dev-shm-usage')    sys
        Evaluate    $options.add_argument('--window-size=1920,1080')    sys
        IF    '${HEADLESS}' == 'TRUE'
            Evaluate    $options.add_argument('--headless=new')    sys
        END
        Open Browser    ${url}    Edge    options=${options}
    ELSE IF    '${browser_lower}' == 'firefox'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys
        Evaluate    $options.add_argument('--window-size=1920,1080')    sys
        IF    '${HEADLESS}' == 'TRUE'
            Evaluate    $options.add_argument('--headless')    sys
        END
        Open Browser    ${url}    Firefox    options=${options}
    ELSE
        Fail    Unsupported browser '${BROWSER}'. Supported values: Chrome, Edge, Firefox.
    END
    IF    '${HEADLESS}' != 'TRUE'
        Maximize Browser Window
    END

Close Browser Session
    Close All Browsers
