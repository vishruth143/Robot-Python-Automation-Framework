<!-- markdownlint-disable MD033 MD041 -->
<div align="center">

# 🤖 Robot-Python-Automation-Framework

**A scalable, maintainable test automation framework for UI and API testing using Robot Framework.**

![Python](https://img.shields.io/badge/Python-3.13-blue?logo=python&logoColor=white)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.4.2-black?logo=robotframework&logoColor=white)
![SeleniumLibrary](https://img.shields.io/badge/SeleniumLibrary-6.8.0-43B02A?logo=selenium&logoColor=white)
![RequestsLibrary](https://img.shields.io/badge/RequestsLibrary-0.9.7-blue)
![pabot](https://img.shields.io/badge/pabot-5.2.2-orange)
![License](https://img.shields.io/badge/License-MIT-green)

Built with Python · Robot Framework · SeleniumLibrary · RequestsLibrary · pabot
Cross-browser UI Testing · REST API Testing · Keyword-Driven & Data-Driven Testing · Page Object Model · CI/CD Ready

</div>

---

## 📑 Table of Contents

1. [Features](#-features)
2. [Prerequisites](#-prerequisites)
3. [Quick Start](#-quick-start)
4. [Project Structure](#-project-structure)
5. [Locator Naming Conventions](#-locator-naming-conventions)
6. [Page Object Model](#-page-object-model)
7. [Variables](#-variables)
8. [Robot Framework CLI Reference](#-robot-framework-cli-reference)
9. [Running Tests](#-running-tests)
   - [Executor Scripts](#executor-scripts)
   - [UI · PTA](#ui--pta)
   - [UI · Heroku](#ui--heroku)
   - [UI · Demo](#ui--demo)
   - [API · JSONPlaceholder](#api--jsonplaceholder)
   - [Browser & Headless Mode Quick Reference](#browser--headless-mode-quick-reference)
   - [Skipping Tests](#skipping-tests)
   - [Parallel Execution (pabot)](#parallel-execution-pabot)
10. [Reports](#-reports)
    - [Built-in Robot Report](#built-in-robot-report)
11. [CI/CD Integration](#-cicd-integration)
    - [GitHub Actions](#-github-actions)
12. [Conventional Commits](#-conventional-commits)
13. [MCP Servers](#-mcp-servers)

---

## ✨ Features

| #  | Feature                                                                                                         | Status |
|----|-----------------------------------------------------------------------------------------------------------------|:------:|
| 1  | 🤖 Robot Framework · Python · SeleniumLibrary UI test automation                                               | ✅     |
| 2  | 🌐 REST API testing with RequestsLibrary (GET, POST, PUT, PATCH, DELETE)                                        | ✅     |
| 3  | 🔧 Python programming support                                                                                    | ✅     |
| 4  | 🌍 Cross-browser UI testing (Chrome, Firefox, Edge) — headless & headful                                        | ✅     |
| 5  | 📝 Keyword-Driven Testing (KDT) with reusable `.robot` resource files                                           | ✅     |
| 6  | 📊 Built-in HTML log, report and XML output                                                                      | ✅     |
| 7  | 🗂️ Resource files for shared keywords and variables                                                             | ✅     |
| 8  | 🧪 Data-driven testing with Robot Framework variables                                                            | ✅     |
| 9  | 🔁 Test Setup & Teardown for browser and session lifecycle management                                            | ✅     |
| 10 | ⚙️ Runtime `--variable` overrides for `BROWSER`, `HEADLESS` and `REGION` — no code changes needed              | ✅     |
| 11 | 🌍 Multi-environment support via `REGION` variable (`DEV`, `QA`, `STAGE`, `PROD`) — URLs defined per-suite in `resource.robot` | ✅     |
| 12 | 🔗 Centralised browser setup in `tests/ui/common/common.robot`; shared API keywords in `tests/api/common/common.robot` | ✅     |
| 13 | ⚡ Parallel test execution via `pabot` (`robotframework-pabot`)                                                  | ✅     |
| 14 | 🏗️ Page Object Model (POM) — locators and keywords separated into dedicated `pages/` files per suite           | ✅     |
| 15 | 📦 Self-contained suites — all env URLs, credentials and payloads live directly in each suite's `resource.robot` | ✅     |
| 16 | 🔐 Credentials read from OS environment variables at runtime (`%{VAR=default}`) — no hardcoded secrets in source  | ✅     |

---

## 🛠 Prerequisites

Ensure the following tools are installed before setting up the project:

| Tool          | Version      | Purpose                                      | Install                                               |
|---------------|--------------|----------------------------------------------|-------------------------------------------------------|
| Python        | 3.10+        | Runtime for Robot Framework and dependencies | [python.org](https://www.python.org/downloads/)       |
| Google Chrome | Latest       | Default browser for test execution           | [chrome](https://www.google.com/chrome/)              |
| ChromeDriver  | Match Chrome | Selenium WebDriver for Chrome                | Auto-managed by SeleniumLibrary                       |
| Node.js       | 18+          | Required for MCP server tools (optional)     | [nodejs.org](https://nodejs.org/)                     |
| Git           | Any          | Source control                               | [git-scm.com](https://git-scm.com/)                   |

> **Note:** Firefox and Edge are also supported. Their respective WebDrivers are managed automatically by SeleniumLibrary.

---

## ⚡ Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/vishruth143/Robot-Python-Automation-Framework.git
cd Robot-Python-Automation-Framework
```

### 2. Create and activate a virtual environment

```powershell
python -m venv .venv
.venv\Scripts\activate
```

### 3. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 4. Run tests

```powershell
# Run PTA UI tests — Chrome headless, QA environment
robot -d output tests/ui/pta/

# Run Heroku UI tests
robot -d output tests/ui/heroku/

# Run API tests
robot -d output tests/api/jsonplaceholder/
```

### 5. View the report

- Open `output/report.html` in a browser, **or**
- Open `output/log.html` for a detailed execution log.

---

## 🚀 Project Structure

```text
Robot-Python-Automation-Framework/
│
├── output/                                         # Auto-generated test artifacts
│   ├── log.html                                    # Detailed Robot Framework execution log
│   ├── output.xml                                  # Raw XML results
│   └── report.html                                 # Robot Framework HTML summary report
│
├── executor/                                       # Batch scripts for one-click test execution
│   ├── pta_ui_tests_executor.bat                   # Cleans output & runs PTA UI tests
│   ├── heroku_ui_tests_executor.bat                # Cleans output & runs Heroku UI tests
│   ├── demo_ui_tests_executor.bat                  # Cleans output & runs Demo UI tests
│   └── jsonplaceholder_api_tests_executor.bat      # Cleans output & runs JSONPlaceholder API tests
│
├── tests/                                          # Test suite root
│   ├── api/                                        # API test suites
│   │   ├── common/
│   │   │   └── common.robot                        # Shared API keywords, HTTP status codes & REGION variable
│   │   └── jsonplaceholder/
│   │       ├── resource.robot                      # Base URLs per region, endpoints, payloads & session keywords
│   │       └── test_jsonplaceholder.robot          # Full CRUD API tests (GET, POST, PUT, PATCH, DELETE)
│   │
│   └── ui/                                         # UI test suites
│       ├── common/
│       │   └── common.robot                        # Shared browser launch/teardown keywords, BROWSER, HEADLESS, REGION, DEFAULT_TIMEOUT
│       │
│       ├── demo/                                   # Demo / learning tests (rahulshettyacademy)
│       │   ├── pages/
│       │   │   ├── login_page.robot                # Login page locators + keywords
│       │   │   └── shop_page.robot                 # Shop page locators + keywords
│       │   ├── resource.robot                      # URLs per region, credentials, CARD_NAME & browser setup keyword
│       │   └── test_demo.robot                     # Login validation + shopping cart tests
│       │
│       ├── heroku/                                 # The Internet Herokuapp UI tests
│       │   ├── pages/
│       │   │   ├── login_page.robot                # Login page locators + keywords
│       │   │   ├── checkboxes_page.robot           # Checkboxes locators + keywords
│       │   │   ├── dropdown_page.robot             # Dropdown locators + keywords
│       │   │   └── add_remove_page.robot           # Add/Remove locators + keywords
│       │   ├── resource.robot                      # URLs per region, credentials, URL paths & browser setup keyword
│       │   └── test_heroku.robot                   # Login, checkboxes, dropdown, add/remove tests
│       │
│       └── pta/                                    # Practice Test Automation (PTA) UI tests
│           ├── pages/
│           │   ├── login_page.robot                # Login page locators + keywords
│           │   └── dashboard_page.robot            # Dashboard page locators + keywords
│           ├── resource.robot                      # URLs per region, credentials & browser setup keyword
│           └── test_pta.robot                      # Login positive/negative + logout tests
│
├── .gitignore
├── README.md
└── requirements.txt
```

---

## 🏷 Locator Naming Conventions

All locators defined in `pages/*.robot` files follow a consistent suffix convention so the element type is immediately clear from the variable name alone.

| Element Type       | Suffix      | Example                              |
|--------------------|-------------|--------------------------------------|
| Button             | `_btn`      | `${login_btn}`                       |
| Text field / Input | `_txt`      | `${username_txt}`                    |
| Password field     | `_pwd`      | `${password_pwd}`                    |
| Link / Anchor      | `_lnk`      | `${logout_lnk}`                      |
| Dropdown / Select  | `_ddl`      | `${region_ddl}`                      |
| Checkbox           | `_chk`      | `${remember_me_chk}`                 |
| Radio button       | `_rdo`      | `${gender_male_rdo}`                 |
| Label / Text span  | `_lbl`      | `${error_message_lbl}`               |
| Header             | `_hdr`      | `${page_title_hdr}`                  |
| Image              | `_img`      | `${logo_img}`                        |
| Table              | `_tbl`      | `${results_tbl}`                     |
| List / `<ul>`      | `_lst`      | `${nav_menu_lst}`                    |
| List item / `<li>` | `_itm`      | `${cart_item_itm}`                   |
| Form               | `_frm`      | `${login_frm}`                       |
| Container / `<div>`| `_ctr`      | `${modal_ctr}`                       |
| Icon               | `_ico`      | `${search_ico}`                      |
| Textarea           | `_area`     | `${comments_area}`                   |
| Alert / Toast      | `_alert`    | `${success_alert}`                   |

### Naming Pattern

```text
${<descriptive_name>_<suffix>}
```

**Examples:**

```robot
# pages/login_page.robot
${username_txt}         id=username
${password_pwd}         id=password
${login_btn}            id=submit
${error_message_lbl}    id=error

# pages/checkboxes_page.robot
${checkbox_1_chk}       css=#checkboxes input:nth-of-type(1)
${checkbox_2_chk}       css=#checkboxes input:nth-of-type(2)

# pages/dropdown_page.robot
${options_ddl}          id=dropdown
```

> 💡 This convention makes locators self-documenting — no need to inspect the HTML to know what type of element a variable represents.

---

## 🏗 Page Object Model

All three UI suites follow the **Page Object Model (POM)** pattern. Each page in the application has a dedicated `.robot` file under a `pages/` folder that **owns** the locators and page-level keywords for that page. Test files contain only test cases — no locators and no keyword definitions.

### POM Principles Applied

| Principle | How it is implemented |
|---|---|
| Locator ownership | Every locator lives in the page file that represents the page it belongs to |
| Keyword encapsulation | All UI interactions and verifications for a page are keywords inside that page's file |
| Clean test files | `test_*.robot` files import page resources and call keywords — no raw locators, no keyword definitions |
| Single change point | When a locator changes, only the relevant `pages/*.robot` file needs updating |
| Scalability | Adding a new page = creating a new `pages/<name>_page.robot` file |

### POM File Responsibilities

#### PTA Suite (`tests/ui/pta/`)

| File | Responsibility |
|---|---|
| `resource.robot` | URLs per region (`&{PTA_URLS}`), credentials, browser setup keyword |
| `pages/login_page.robot` | Login locators · `Fill The Login Form` · `Submit Empty Login Form` · `Verify Error Message` · `Verify Error Message Is Visible` · `Verify Redirected To Login Page` |
| `pages/dashboard_page.robot` | Dashboard locators · `Verify Successful Login` · `Click Logout Button` |
| `test_pta.robot` | 5 test cases — imports the 3 files above |

#### Heroku Suite (`tests/ui/heroku/`)

| File | Responsibility |
|---|---|
| `resource.robot` | URLs per region (`&{HEROKU_URLS}`), credentials, URL paths, browser setup keyword |
| `pages/login_page.robot` | Auth locators · `Login With` · `Verify Successful Login` · `Verify Login Error` · `Logout And Verify Redirected To Login` |
| `pages/checkboxes_page.robot` | Checkbox locators · `Check Checkbox 1 And Verify Selected` · `Uncheck Checkbox 2 And Verify Deselected` |
| `pages/dropdown_page.robot` | Dropdown locators · `Select Dropdown Option And Verify` |
| `pages/add_remove_page.robot` | Add/Remove locators · `Add Element And Verify Count` · `Add Multiple Elements And Verify Count` · `Add Element Then Delete And Verify Gone` |
| `test_heroku.robot` | 11 test cases — imports the 5 files above |

#### Demo Suite (`tests/ui/demo/`)

| File | Responsibility |
|---|---|
| `resource.robot` | URLs per region (`&{DEMO_URLS}`), credentials, `CARD_NAME`, browser setup keyword |
| `pages/login_page.robot` | Login locators · `Fill The Login Form` · `Verify Login Error Message` |
| `pages/shop_page.robot` | Shop locators · `Verify Shop Page Is Loaded` · `Verify Card Titles In The Shop Page` · `Select Card By Name` |
| `test_demo.robot` | 3 test cases — imports the 3 files above |

---

## 🌱 Variables

### UI Variables

Defined in `tests/ui/common/common.robot` and inherited by all UI suite `resource.robot` files.

| Variable          | Description                           | Default  | Accepted Values              | Required |
|-------------------|---------------------------------------|----------|------------------------------|:--------:|
| `BROWSER`         | Browser to launch                     | `Chrome` | `Chrome`, `Edge`, `Firefox`  | Optional |
| `HEADLESS`        | Run without a visible browser window  | `TRUE`   | `TRUE`, `FALSE`              | Optional |
| `REGION`          | Target environment                    | `QA`     | `DEV`, `QA`, `STAGE`, `PROD` | Optional |
| `DEFAULT_TIMEOUT` | Global element wait timeout (seconds) | `10`     | Any positive integer         | Optional |

### Credential Environment Variables

Credentials are read from OS environment variables at runtime using Robot Framework's `%{VAR=default}` syntax. If the env var is not set, the built-in default is used — tests work out-of-the-box with no configuration required.

| Environment Variable  | Suite(s)              | Default value              |
|-----------------------|-----------------------|----------------------------|
| `VALID_USERNAME`      | pta, heroku, demo     | Suite-specific (see below) |
| `VALID_PASSWORD`      | pta, heroku, demo     | Suite-specific (see below) |
| `INVALID_USERNAME`    | pta, heroku, demo     | Suite-specific (see below) |
| `INVALID_PASSWORD`    | pta, heroku, demo     | Suite-specific (see below) |

**Set credentials before running (PowerShell):**

```powershell
$env:VALID_USERNAME = "myuser"
$env:VALID_PASSWORD = "mypassword"
robot -d output tests/ui/pta/
```

**Or pass directly via `--variable`:**

```powershell
robot -d output --variable VALID_USERNAME:myuser --variable VALID_PASSWORD:mypassword tests/ui/pta/
```

### API Variables

Defined in `tests/api/common/common.robot` and inherited by all API suite `resource.robot` files.

| Variable          | Description            | Default | Accepted Values              | Required |
|-------------------|------------------------|---------|------------------------------|:--------:|
| `REGION`          | Target environment     | `QA`    | `DEV`, `QA`, `STAGE`, `PROD` | Optional |
| `DEFAULT_TIMEOUT` | Request timeout (secs) | `30`    | Any positive integer         | Optional |

### Suite-Level Variables (in each `resource.robot`)

Each suite defines its own URL dictionary and credentials directly in `resource.robot`. The correct URL is resolved at runtime from the dictionary using `${REGION}`.

| Suite | Variable | Description |
|---|---|---|
| `pta` | `&{PTA_URLS}` | URL per region |
| `pta` | `${VALID_USERNAME}`, `${VALID_PASSWORD}`, `${INVALID_USERNAME}`, `${INVALID_PASSWORD}` | Login credentials — read from OS env vars (`%{VAR=default}`) |
| `heroku` | `&{HEROKU_URLS}` | URL per region |
| `heroku` | `${VALID_USERNAME}`, `${VALID_PASSWORD}`, `${INVALID_USERNAME}`, `${INVALID_PASSWORD}` | Login credentials — read from OS env vars (`%{VAR=default}`) |
| `heroku` | `${login_url}`, `${checkboxes_url}`, `${dropdown_url}`, `${add_remove_url}` | URL path segments |
| `demo` | `&{DEMO_URLS}` | URL per region (real DEV/STAGE/PROD URLs) |
| `demo` | `${VALID_USERNAME}`, `${VALID_PASSWORD}`, `${INVALID_USERNAME}`, `${INVALID_PASSWORD}`, `${CARD_NAME}` | Credentials + test data — credentials read from OS env vars (`%{VAR=default}`) |
| `jsonplaceholder` | `&{JSONPLACEHOLDER_URLS}` | Base URL per region |
| `jsonplaceholder` | `&{CREATE_POST_PAYLOAD}`, `&{UPDATE_POST_PAYLOAD}`, `&{PATCH_POST_PAYLOAD}`, `&{CREATE_COMMENT_PAYLOAD}` | Request payloads |

Override at runtime — **no code changes needed**:

```powershell
robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE --variable REGION:STAGE tests/ui/pta/
```

### Headless Mode Arguments per Browser

| Browser | Headless arguments applied                                    |
|---------|---------------------------------------------------------------|
| Chrome  | `--headless=new`, `--disable-gpu`, `--window-size=1920,1080` |
| Edge    | `--headless=new`, `--disable-gpu`, `--window-size=1920,1080` |
| Firefox | `--headless`, `--width=1920`, `--height=1080`                |

> **Note:** If an unsupported browser name is passed, the test fails immediately with:
> `Unsupported browser '<value>'. Supported values: Chrome, Edge, Firefox.`

---

## 🚩 Robot Framework CLI Reference

| Flag / Option                       | Description                                                          |
|-------------------------------------|----------------------------------------------------------------------|
| `-d <dir>` / `--outputdir <dir>`    | Directory for output files (`log.html`, `report.html`, `output.xml`) |
| `-o <file>` / `--output <file>`     | Output XML file name (default: `output.xml`)                         |
| `-l <file>` / `--log <file>`        | Log file name (default: `log.html`)                                  |
| `-r <file>` / `--report <file>`     | Report file name (default: `report.html`)                            |
| `-i <tag>` / `--include <tag>`      | Run only tests with matching tag (e.g. `--include smoke`)            |
| `-e <tag>` / `--exclude <tag>`      | Exclude tests with matching tag                                       |
| `-t <name>` / `--test <name>`       | Run a specific test case by name                                      |
| `-s <name>` / `--suite <name>`      | Run a specific test suite by name                                     |
| `--variable <name>:<value>`         | Override a variable at runtime (e.g. `--variable BROWSER:Firefox`)   |
| `--loglevel <level>`                | Set log level (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`)            |
| `--dryrun`                          | Verify test syntax without executing                                  |
| `--rerunfailed <output.xml>`        | Re-run only failed test cases from a previous run                    |
| `--rerunfailedsuites <output.xml>`  | Re-run suites containing failed tests from a previous run            |
| `-P <path>` / `--pythonpath <path>` | Extra path(s) to add to Python's module search path                  |
| `--listener <class>`                | Register a listener class to receive execution events                |
| `--nostatusrc`                      | Always exit with code 0 (useful in CI to avoid pipeline failure)     |

---

## 🧪 Running Tests

### Executor Scripts

The `executor/` folder contains ready-to-use `.bat` scripts for one-click test execution. Each script:

- Automatically navigates to the project root
- Deletes the `output/` folder if it exists (clean run)
- Launches the corresponding Robot Framework test suite

| Script                                    | Suite                          | Default Settings              |
|-------------------------------------------|--------------------------------|-------------------------------|
| `pta_ui_tests_executor.bat`               | `tests/ui/pta/`                | Chrome · Headless · QA region |
| `heroku_ui_tests_executor.bat`            | `tests/ui/heroku/`             | Chrome · Headless · QA region |
| `demo_ui_tests_executor.bat`              | `tests/ui/demo/`               | Chrome · Headful · QA region  |
| `jsonplaceholder_api_tests_executor.bat`  | `tests/api/jsonplaceholder/`   | QA region                     |

**Execute from PowerShell (from any directory):**

```powershell
.\executor\pta_ui_tests_executor.bat
.\executor\heroku_ui_tests_executor.bat
.\executor\demo_ui_tests_executor.bat
.\executor\jsonplaceholder_api_tests_executor.bat
```

> **Note:** `BROWSER`, `HEADLESS`, and `REGION` defaults can be changed directly inside each `.bat` file — no other code changes needed. Credentials (`VALID_USERNAME`, `VALID_PASSWORD`, etc.) are read from OS environment variables; commented-out `set` examples are provided inside each `.bat` file.

---

### UI · PTA

Tests cover login (positive & negative), logout, and empty-field validation against [practicetestautomation.com](https://practicetestautomation.com/practice-test-login/).

| Test Case | Description                           |
|-----------|---------------------------------------|
| TC1       | Positive login with valid credentials |
| TC2       | Negative login with invalid username  |
| TC3       | Negative login with invalid password  |
| TC4       | Verify logout after successful login  |
| TC5       | Negative login with both fields empty |

```powershell
# Chrome headless, QA (default)
robot -d output tests/ui/pta/

# Chrome headful
robot -d output --variable HEADLESS:FALSE tests/ui/pta/

# Firefox headless
robot -d output --variable BROWSER:Firefox tests/ui/pta/

# Edge headful
robot -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/pta/

# Run against STAGE environment
robot -d output --variable REGION:STAGE tests/ui/pta/
```

---

### UI · Heroku

Tests cover form authentication, checkboxes, dropdown, and add/remove elements against [the-internet.herokuapp.com](https://the-internet.herokuapp.com/).

| Test Case | Area                | Description                                    |
|-----------|---------------------|------------------------------------------------|
| TC1       | Form Authentication | Successful login with valid credentials        |
| TC2       | Form Authentication | Unsuccessful login with invalid username       |
| TC3       | Form Authentication | Unsuccessful login with invalid password       |
| TC4       | Form Authentication | Logout after successful login                  |
| TC5       | Checkboxes          | Check checkbox 1 and verify it is selected     |
| TC6       | Checkboxes          | Uncheck checkbox 2 and verify it is deselected |
| TC7       | Dropdown            | Select Option 1 from dropdown                  |
| TC8       | Dropdown            | Select Option 2 from dropdown                  |
| TC9       | Add / Remove        | Add an element and verify it appears           |
| TC10      | Add / Remove        | Add multiple elements and verify count         |
| TC11      | Add / Remove        | Add then delete an element                     |

```powershell
# Chrome headless, QA (default)
robot -d output tests/ui/heroku/

# Firefox headful
robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/heroku/

# Run against STAGE
robot -d output --variable REGION:STAGE tests/ui/heroku/
```

---

### UI · Demo

Tests cover login validation and shopping cart card verification against [rahulshettyacademy.com](https://rahulshettyacademy.com/loginpagePractise).

| Test Case | Description                                 |
|-----------|---------------------------------------------|
| TC1       | Validate un-successful login                |
| TC2       | Validate cards display in the shopping page |
| TC3       | Select the card by name from the shop page  |

```powershell
# Run all tests in the demo suite (Chrome headless, QA by default)
robot -d output tests/ui/demo/

# Run a single test case by name
robot -d output --test "TC1 - Validate un-successful login" tests/ui/demo/test_demo.robot

# Run with Edge in headful mode
robot -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/demo/

# Run against STAGE (uses real stage URL from DEMO_URLS in resource.robot)
robot -d output --variable REGION:STAGE tests/ui/demo/
```

Re-run only failed tests from the last run:

```powershell
robot -d output --rerunfailed output/output.xml tests/
```

---

### API · JSONPlaceholder

Full CRUD test suite against the public [JSONPlaceholder REST API](https://jsonplaceholder.typicode.com). Covers `GET`, `POST`, `PUT`, `PATCH` and `DELETE` operations on `/posts`, `/comments`, `/users` and `/todos`.

| Test Case | Method | Endpoint | Description |
|-----------|--------|----------|-------------|
| TC1 | GET | `/posts` | Returns all posts as a non-empty list |
| TC2 | GET | `/posts/1` | Returns the correct single post |
| TC3 | POST | `/posts` | Creates a new post (201) |
| TC4 | PUT | `/posts/1` | Fully updates a post (200) |
| TC5 | PATCH | `/posts/1` | Partially updates a post (200) |
| TC6 | DELETE | `/posts/1` | Deletes a post and returns empty body |
| TC7 | GET | `/posts/1/comments` | Returns comments for post 1 |
| TC8 | GET | `/users` | Returns exactly 10 users |
| TC9 | GET | `/users/1/todos` | Returns todos for user 1 |

```powershell
# Run all API tests (QA)
robot -d output tests/api/jsonplaceholder/

# Run against STAGE
robot -d output --variable REGION:STAGE tests/api/jsonplaceholder/
```

---

### Browser & Headless Mode Quick Reference

| Browser | Mode     | Command                                                                          |
|---------|----------|----------------------------------------------------------------------------------|
| Chrome  | Headless | `robot -d output tests/ui/`                                                      |
| Chrome  | Headful  | `robot -d output --variable HEADLESS:FALSE tests/ui/`                            |
| Edge    | Headless | `robot -d output --variable BROWSER:Edge tests/ui/`                              |
| Edge    | Headful  | `robot -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/`    |
| Firefox | Headless | `robot -d output --variable BROWSER:Firefox tests/ui/`                           |
| Firefox | Headful  | `robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/` |

---

### Skipping Tests

Robot Framework provides several ways to skip specific test cases during execution without modifying test files.

#### Option 1 — Exclude by Tag (`--exclude`)

Add a tag to any test case you want to skip, then exclude it at runtime.

**Step 1:** Uncomment (or add) `[Tags]` in the test:

```robot
TC3 - Negative login with invalid password
    [Tags]    skip
    Fill The Login Form    ${valid_user_name}    ${invalid_password}
    Verify Error Message    Your password is invalid!
```

**Step 2:** Run with `--exclude`:

```powershell
# Skip all tests tagged 'skip'
robot -d output --exclude skip tests/ui/pta/

# Skip multiple tags
robot -d output --exclude skip --exclude wip tests/ui/pta/
```

> 💡 All test files already have `#    [Tags]    skip` commented out on each test case — simply uncomment the line(s) you want to skip.

#### Option 2 — Run Only Specific Tests (`--include` / `--test`)

```powershell
# Run only tests tagged 'smoke'
robot -d output --include smoke tests/ui/

# Run a single test by exact name
robot -d output --test "TC1 - Positive login with valid credentials" tests/ui/pta/test_pta.robot
```

#### Option 3 — `--skip` Flag (Robot Framework 5+)

```powershell
# Skip by test name pattern
robot -d output --skip "TC3*" tests/ui/pta/
```

> **Note:** Skipped tests appear in the report as **SKIP** (grey) — counted separately from PASS and FAIL.

#### Skipping Quick Reference

| Goal                          | Command                                                           |
|-------------------------------|-------------------------------------------------------------------|
| Skip tests tagged `skip`      | `robot -d output --exclude skip tests/ui/`                        |
| Run only tests tagged `smoke` | `robot -d output --include smoke tests/ui/`                       |
| Run one test by name          | `robot -d output --test "TC1 - Positive login with valid credentials" tests/ui/pta/test_pta.robot`  |
| Skip by name pattern (RF 5+)  | `robot -d output --skip "TC3*" tests/ui/pta/`                     |

---

### Parallel Execution (pabot)

[`robotframework-pabot`](https://pabot.org/) (v5.2.2) is included in `requirements.txt` and lets you run Robot Framework suites or test cases in parallel, significantly reducing overall execution time.

> **Important:** All `pabot` (and `robot`) commands below must be run from the **project root** (`Robot-Python-Automation-Framework/`).

#### Run Suites in Parallel (Suite-Level — Default)

```powershell
# Run all UI suites in parallel
pabot -d output tests/ui/

# Specify the number of parallel processes
pabot --processes 3 -d output tests/ui/
```

#### Run Test Cases in Parallel (Test-Level)

```powershell
# Run all tests in parallel at test level
pabot --testlevelsplit -d output tests/ui/

# Combine with explicit process count
pabot --testlevelsplit --processes 4 -d output tests/ui/
```

> ⚠️ Use `--testlevelsplit` only when tests are fully independent (no shared state between test cases).

#### Pass Robot Framework Variables with pabot

```powershell
# Run in parallel — Firefox, headful, STAGE environment
pabot --processes 3 -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE --variable REGION:STAGE tests/ui/

# Run only tests tagged 'smoke' in parallel
pabot --processes 2 -d output --include smoke tests/ui/
```

#### Parallel Execution Quick Reference

| Goal                               | Command (run from project root)                                             |
|------------------------------------|-----------------------------------------------------------------------------|
| Run all suites in parallel         | `pabot -d output tests/ui/`                                                 |
| Set process count                  | `pabot --processes 4 -d output tests/ui/`                                   |
| Run tests in parallel (test-level) | `pabot --testlevelsplit -d output tests/ui/`                                |
| Parallel + custom browser          | `pabot -d output --variable BROWSER:Edge tests/ui/`                         |
| Parallel + tag filter              | `pabot -d output --include smoke tests/ui/`                                 |
| Parallel + headful mode            | `pabot -d output --variable HEADLESS:FALSE tests/ui/`                       |

---

## 📊 Reports

### Built-in Robot Report

Robot Framework automatically generates three output files after every run in the directory specified by `-d`:

| File          | Description                                                         |
|---------------|---------------------------------------------------------------------|
| `report.html` | High-level summary — pass/fail counts, suite statistics, tag report |
| `log.html`    | Detailed interactive log — every keyword call, argument and result  |
| `output.xml`  | Machine-readable XML — used for re-runs and CI integrations         |

Open them in any browser:

```text
output/report.html
output/log.html
```

Merge results from multiple runs:

```powershell
rebot --merge -d output output/output.xml output/output_2.xml
```

---

## 🔁 CI/CD Integration

### 🐙 GitHub Actions

The pipeline triggers automatically when changes are pushed or merged to `main`.

**Sample workflow** (`.github/workflows/ci.yml`):

```yaml
name: Robot Framework CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.13"

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Install Chrome
        uses: browser-actions/setup-chrome@v1

      - name: Run UI tests
        env:
          VALID_USERNAME: ${{ secrets.VALID_USERNAME }}
          VALID_PASSWORD: ${{ secrets.VALID_PASSWORD }}
        run: robot -d output --variable BROWSER:Chrome --variable HEADLESS:TRUE tests/ui/

      - name: Run API tests
        run: robot -d output/api --variable REGION:QA tests/api/

      - name: Upload Robot Reports
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: robot-reports
          path: output/
```

**Viewing results:**

1. Go to the **Actions** tab in GitHub → select the latest workflow run.
2. Download `robot-reports.zip` from the **Artifacts** section.
3. Extract the zip and open `report.html` in your browser.

---

## 📝 Conventional Commits

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```text
<type>(<optional scope>): <short summary>

<optional body — explains WHAT and WHY>

<optional footer — e.g. BREAKING CHANGE, closes #issue>
```

### Type Prefixes

| Prefix     | When to use                                                             | Example                                                            |
|------------|-------------------------------------------------------------------------|--------------------------------------------------------------------|
| `feat`     | A new feature                                                           | `feat(pta): add login validation test`                             |
| `fix`      | A bug fix                                                               | `fix(heroku): correct login locator selector`                      |
| `chore`    | Routine tasks, dependency updates, tooling — no production logic change | `chore(deps): bump robotframework 7.4.1 → 7.4.2`                  |
| `docs`     | Documentation-only changes                                              | `docs(readme): update project structure section`                   |
| `style`    | Formatting, whitespace — no logic change                                | `style: reformat resource.robot keywords`                          |
| `refactor` | Code restructured without fixing a bug or adding a feature              | `refactor(common): extract browser setup into common/common.robot` |
| `test`     | Adding or updating tests                                                | `test(heroku): add add-remove elements test`                       |
| `ci`       | Changes to CI/CD pipeline files                                         | `ci: add GitHub Actions Robot Framework workflow`                  |
| `build`    | Changes affecting the build system or external dependencies             | `build: upgrade to Python 3.13`                                    |
| `revert`   | Reverts a previous commit                                               | `revert: revert "feat(pta): add login test"`                       |

### Scopes

| Scope      | Refers to                                                                  |
|------------|----------------------------------------------------------------------------|
| `deps`     | `requirements.txt` dependency changes                                      |
| `common`   | `tests/ui/common/common.robot` or `tests/api/common/common.robot`          |
| `pta`      | PTA UI test suite (`tests/ui/pta/`)                                        |
| `heroku`   | The Internet Herokuapp UI test suite (`tests/ui/heroku/`)                  |
| `demo`     | Demo/learning tests (`tests/ui/demo/`)                                     |
| `api`      | API test suites (`tests/api/`)                                             |
| `pom`      | Page Object Model — `pages/` files across any suite                        |
| `executor` | Batch executor scripts (`executor/`)                                       |
| `pabot`    | Parallel execution configuration and pabot-related changes                 |
| `ci`       | `.github/workflows/`, CI pipeline files                                    |
| `readme`   | `README.md`                                                                |

### Quick Examples

```text
feat(executor): add jsonplaceholder_api_tests_executor.bat

feat(api): add jsonplaceholder CRUD test suite with RequestsLibrary

refactor(resource): move env URLs and credentials inline into resource.robot files — remove config_loader.py

fix(pta): fix TC4 logout verification to use Verify Redirected To Login Page

fix(api): add REGION variable to tests/api/common/common.robot

chore(deps): add robotframework-requests==0.9.7 for API testing
```

---

## 🤖 MCP Servers

This project uses [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) servers to extend GitHub Copilot with browser automation, filesystem access, REST API testing, database access, and more.

The configuration file lives at:

```text
%LOCALAPPDATA%\github-copilot\intellij\mcp.json
```

### MCP Server Reference

| Server                  | Package                                   | Purpose                                                               |
|-------------------------|-------------------------------------------|-----------------------------------------------------------------------|
| `github`                | GitHub Copilot MCP (remote)               | GitHub repo, PR, issue, and search management                         |
| `playwright`            | `@playwright/mcp@latest`                  | Browser automation — navigate, click, screenshot, snapshot            |
| `selenium`              | `@angiejones/mcp-selenium`                | Selenium WebDriver interactions for browser testing                   |
| `filesystem`            | `@modelcontextprotocol/server-filesystem` | Read/write files within allowed local directories                     |
| `excel`                 | `@negokaz/excel-mcp-server`               | Read and write Excel files                                            |
| `rest-api`              | `dkmaker-mcp-rest-api`                    | Test REST API endpoints (base URL: `https://rahulshettyacademy.com/`) |
| `mysql`                 | `mysql_mcp_server`                        | Execute SQL queries against a local MySQL database                    |
| `word-document-server`  | `office-word-mcp-server`                  | Create and edit Word documents                                        |
| `mcp-atlassian`         | `mcp-atlassian`                           | Jira and Confluence integration                                       |

### `mcp.json`

```json
{
  "servers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "selenium": {
      "command": "npx",
      "args": ["-y", "@angiejones/mcp-selenium"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\<your-username>\\files_claude"
      ]
    },
    "excel": {
      "command": "cmd",
      "args": ["/c", "npx", "--yes", "@negokaz/excel-mcp-server"],
      "env": {
        "EXCEL_MCP_PAGING_CELLS_LIMIT": "4000"
      }
    },
    "rest-api": {
      "command": "node",
      "args": [
        "C:\\Users\\<your-username>\\AppData\\Roaming\\npm\\node_modules\\dkmaker-mcp-rest-api\\build\\index.js"
      ],
      "env": {
        "REST_BASE_URL": "https://rahulshettyacademy.com/",
        "HEADER_Accept": "application/json"
      }
    },
    "mysql": {
      "command": "C:\\Python\\3.13.7\\Scripts\\uv.exe",
      "args": [
        "--directory",
        "C:\\Python\\3.13.7\\Lib\\site-packages",
        "run",
        "mysql_mcp_server"
      ],
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASSWORD": "root",
        "MYSQL_DATABASE": "rahulshettyacademy"
      }
    },
    "word-document-server": {
      "command": "uvx",
      "args": ["--from", "office-word-mcp-server", "word_mcp_server"]
    },
    "mcp-atlassian": {
      "command": "uvx",
      "args": ["mcp-atlassian"],
      "env": {
        "JIRA_URL": "https://your-domain.atlassian.net",
        "JIRA_USERNAME": "your-email@example.com",
        "JIRA_API_TOKEN": "your_jira_api_token_here",
        "CONFLUENCE_URL": "https://your-company.atlassian.net/wiki",
        "CONFLUENCE_USERNAME": "your.email@company.com",
        "CONFLUENCE_API_TOKEN": "your_api_token"
      }
    }
  }
}
```

### Prerequisites

```bash
# Node.js (for npx-based servers)
node --version   # v18+ recommended

# Install the REST API MCP server globally
npm install -g dkmaker-mcp-rest-api
```

> **Note:** Replace `<your-username>` in all paths above with your actual Windows username before using the config.

---

<div align="center">

### 🤖 Happy Testing! 🤖

</div>
