<!-- markdownlint-disable MD033 MD041 -->
<div align="center">

# 🤖 Robot-Python-Automation-Framework

**A scalable, maintainable test automation framework for UI testing using Robot Framework.**

![Python](https://img.shields.io/badge/Python-3.13-blue?logo=python&logoColor=white)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.4.2-black?logo=robotframework&logoColor=white)
![SeleniumLibrary](https://img.shields.io/badge/SeleniumLibrary-6.8.0-43B02A?logo=selenium&logoColor=white)
![pabot](https://img.shields.io/badge/pabot-5.2.2-orange)
![License](https://img.shields.io/badge/License-MIT-green)

Built with Python · Robot Framework · SeleniumLibrary · pabot
Cross-browser UI Testing · Keyword-Driven & Data-Driven Testing · Page Object Model · Config-Driven · CI/CD Ready

</div>

---

## 📑 Table of Contents

1. [Features](#-features)
2. [Prerequisites](#️-prerequisites)
3. [Quick Start](#-quick-start)
4. [Project Structure](#-project-structure)
5. [Page Object Model](#-page-object-model)
6. [Config-Driven Test Data](#-config-driven-test-data)
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
| 1  | 🤖 Robot Framework · Python · SeleniumLibrary test automation                                                   | ✅     |
| 2  | 🔧 Python programming support                                                                                    | ✅     |
| 3  | 🌐 Cross-browser UI testing (Chrome, Firefox, Edge) — headless & headful                                        | ✅     |
| 4  | 📝 Keyword-Driven Testing (KDT) with reusable `.robot` resource files                                           | ✅     |
| 5  | 📊 Built-in HTML log, report and XML output                                                                      | ✅     |
| 6  | 🗂️ Resource files for shared keywords and variables                                                             | ✅     |
| 7  | 🧪 Data-driven testing with Robot Framework variables                                                            | ✅     |
| 8  | 🔁 Test Setup & Teardown for browser lifecycle management                                                        | ✅     |
| 9  | 🧩 Reusable demo tests for validation and learning                                                               | ✅     |
| 10 | ⚙️ Runtime `--variable` overrides for `BROWSER`, `HEADLESS` and `REGION` — no code changes needed              | ✅     |
| 11 | 🌍 Multi-environment support via `REGION` variable (`DEV`, `QA`, `STAGE`, `PROD`)                              | ✅     |
| 12 | 🔗 Centralised browser setup and variables (`BROWSER`, `HEADLESS`, `REGION`) in `tests/ui/common/common.robot` | ✅     |
| 13 | ⚡ Parallel test execution via `pabot` (`robotframework-pabot`)                                                  | ✅     |
| 14 | 🏗️ Page Object Model (POM) — locators and keywords separated into dedicated `pages/` files per suite           | ✅     |
| 15 | 🗃️ Config-driven test data — environment URLs and credentials loaded from `config/` YAML/JSON via `config_loader.py` | ✅     |

---

## 🛠️ Prerequisites

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
# Run all UI tests — Chrome headless, QA environment (loads config automatically)
robot --variablefile config/config_loader.py:pta:QA -d output tests/ui/pta/

# Run a specific suite
robot --variablefile config/config_loader.py:heroku:QA -d output tests/ui/heroku/

# Run API tests
robot --variablefile config/config_loader.py:api_jsonplaceholder:QA -d output tests/api/
```

### 5. View the report

- Open `output/report.html` in a browser, **or**
- Open `output/log.html` for a detailed execution log.

---

## 🚀 Project Structure

```text
Robot-Python-Automation-Framework/
│
├── config/                                         # Config-driven environment & test data
│   ├── common_config.yml                           # Global defaults: browser, headless, region, default_timeout
│   ├── config_loader.py                            # --variablefile loader — injects env URLs & credentials into Robot
│   ├── api/
│   │   └── jsonplaceholder/
│   │       ├── api_test_env_config.yml             # JSONPlaceholder base URL per region
│   │       └── api_test_data_config.json           # CRUD request payloads (CreatePost, UpdatePost, etc.)
│   └── ui/
│       ├── demo/
│       │   ├── ui_test_env_config.yml              # Demo app URLs per region (real DEV/STAGE/PROD)
│       │   ├── ui_test_data_config.yml             # Demo credentials & card_name  ⚠️ gitignored
│       │   └── ui_test_data_config.yml.example     # Safe template for teams
│       ├── heroku/
│       │   ├── ui_test_env_config.yml              # Heroku URLs per region
│       │   ├── ui_test_data_config.yml             # Heroku credentials  ⚠️ gitignored
│       │   └── ui_test_data_config.yml.example
│       └── pta/
│           ├── ui_test_env_config.yml              # PTA URLs per region
│           ├── ui_test_data_config.yml             # PTA credentials  ⚠️ gitignored
│           └── ui_test_data_config.yml.example
│
├── output/                                         # Auto-generated test artifacts
│   ├── log.html                                    # Detailed Robot Framework execution log
│   ├── output.xml                                  # Raw XML results
│   └── report.html                                 # Robot Framework HTML summary report
│
├── executor/                                       # Batch scripts for one-click test execution
│   ├── pta_ui_tests_executor.bat                   # Cleans output & runs PTA UI tests
│   ├── heroku_ui_tests_executor.bat                # Cleans output & runs Heroku UI tests
│   └── demo_ui_tests_executor.bat                  # Cleans output & runs Demo UI tests
│
├── tests/                                          # Test suite root
│   ├── api/                                        # API test suites
│   │   ├── common/
│   │   │   └── common.robot                        # Shared API session keywords & HTTP status variables
│   │   └── jsonplaceholder/
│   │       ├── resource.robot                      # JSONPlaceholder session, endpoints & field lists
│   │       └── test_jsonplaceholder.robot          # Full CRUD API tests (GET, POST, PUT, PATCH, DELETE)
│   │
│   └── ui/                                         # UI test suites
│       ├── common/
│       │   └── common.robot                        # Shared browser launch, teardown keywords & DEFAULT_TIMEOUT
│       │
│       ├── demo/                                   # Demo / learning tests (rahulshettyacademy)
│       │   ├── pages/
│       │   │   ├── login_page.robot                # Login page locators + Fill The Login Form, Verify Login Error Message
│       │   │   └── shop_page.robot                 # Shop page locators + Verify Shop Page Is Loaded, Verify Card Titles, Select Card By Name
│       │   ├── resource.robot                      # Browser setup keyword (URLs & credentials injected by config_loader)
│       │   └── test_demo.robot                     # Login validation + shopping cart tests (test cases only)
│       │
│       ├── heroku/                                 # The Internet Herokuapp UI tests
│       │   ├── pages/
│       │   │   ├── login_page.robot                # Login page locators + Login With, Verify Successful Login, Verify Login Error, Logout And Verify Redirected To Login
│       │   │   ├── checkboxes_page.robot           # Checkboxes locators + Check/Uncheck and verify keywords
│       │   │   ├── dropdown_page.robot             # Dropdown locators + Select Dropdown Option And Verify
│       │   │   └── add_remove_page.robot           # Add/Remove locators + Add/Delete element keywords
│       │   ├── resource.robot                      # URL paths + browser setup keyword (credentials injected by config_loader)
│       │   └── test_heroku.robot                   # Login, checkboxes, dropdown, add/remove tests (test cases only)
│       │
│       └── pta/                                    # Practice Test Automation (PTA) UI tests
│           ├── pages/
│           │   ├── login_page.robot                # Login page locators + Fill The Login Form, Submit Empty Login Form, Verify Error Message
│           │   └── dashboard_page.robot            # Dashboard page locators + Verify Successful Login, Click Logout Button
│           ├── resource.robot                      # Browser setup keyword (URLs & credentials injected by config_loader)
│           └── test_pta.robot                      # Login positive/negative + logout tests (test cases only)
│
├── .gitignore
├── README.md
└── requirements.txt
```

---

## 🏗️ Page Object Model

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
| `resource.robot` | Browser setup keyword (`Open the browser with the PTA website url`) — URLs & credentials injected by config_loader |
| `pages/login_page.robot` | Login locators · `Fill The Login Form` · `Submit Empty Login Form` · `Verify Error Message` · `Verify Error Message Is Visible` |
| `pages/dashboard_page.robot` | Dashboard locators · `Verify Successful Login` · `Click Logout Button` |
| `test_pta.robot` | 5 test cases — imports the 3 files above |

#### Heroku Suite (`tests/ui/heroku/`)

| File | Responsibility |
|---|---|
| `resource.robot` | URL paths (`/login`, `/checkboxes`, etc.) + browser setup keyword (`Open Herokuapp Page`) — credentials injected by config_loader |
| `pages/login_page.robot` | Auth locators · `Login With` · `Verify Successful Login` · `Verify Login Error` · `Logout And Verify Redirected To Login` · `Element Text Should Contain` |
| `pages/checkboxes_page.robot` | Checkbox locators · `Check Checkbox 1 And Verify Selected` · `Uncheck Checkbox 2 And Verify Deselected` |
| `pages/dropdown_page.robot` | Dropdown locators · `Select Dropdown Option And Verify` |
| `pages/add_remove_page.robot` | Add/Remove locators · `Add Element And Verify Count` · `Add Multiple Elements And Verify Count` · `Add Element Then Delete And Verify Gone` |
| `test_heroku.robot` | 11 test cases — imports the 5 files above |

#### Demo Suite (`tests/ui/demo/`)

| File | Responsibility |
|---|---|
| `resource.robot` | Browser setup keyword (`Open the browser with the login page practice url`) — URLs & credentials injected by config_loader |
| `pages/login_page.robot` | Login locators · `Fill The Login Form` · `Verify Login Error Message` |
| `pages/shop_page.robot` | Shop locators · `Verify Shop Page Is Loaded` · `Verify Card Titles In The Shop Page` · `Select Card By Name` |
| `test_demo.robot` | 3 test cases — imports the 3 files above |

---

## 🗃️ Config-Driven Test Data

All environment URLs and test credentials are externalised into YAML/JSON files under `config/` and injected into Robot Framework at runtime via `--variablefile config/config_loader.py:<suite>:<region>`. No hardcoded values exist in any `.robot` file.

### Config File Structure

```text
config/
├── common_config.yml                    ← Global defaults (browser, headless, region, default_timeout)
├── config_loader.py                     ← Python --variablefile loader (suite + region → RF variables)
├── api/
│   └── jsonplaceholder/
│       ├── api_test_env_config.yml      ← Base URL per region
│       └── api_test_data_config.json   ← Request payloads (CreatePost, UpdatePost, PatchPost, CreateComment)
└── ui/
    ├── pta/
    │   ├── ui_test_env_config.yml       ← URLs per region
    │   ├── ui_test_data_config.yml      ← Credentials  ⚠️ add to .gitignore
    │   └── ui_test_data_config.yml.example
    ├── heroku/
    │   ├── ui_test_env_config.yml
    │   ├── ui_test_data_config.yml      ⚠️ add to .gitignore
    │   └── ui_test_data_config.yml.example
    └── demo/
        ├── ui_test_env_config.yml
        ├── ui_test_data_config.yml      ⚠️ add to .gitignore
        └── ui_test_data_config.yml.example
```

### Variables Injected per Suite

| Suite | Variable | Source |
|---|---|---|
| `pta`, `heroku`, `demo` | `APP_URL` | `ui_test_env_config.yml[REGION].url` |
| `pta`, `heroku`, `demo` | `VALID_USERNAME`, `VALID_PASSWORD` | `ui_test_data_config.yml` |
| `pta`, `heroku`, `demo` | `INVALID_USERNAME`, `INVALID_PASSWORD` | `ui_test_data_config.yml` |
| `demo` only | `CARD_NAME` | `ui_test_data_config.yml` |
| `api_jsonplaceholder` | `JSONPLACEHOLDER_BASE_URL` | `api_test_env_config.yml[REGION].base_url` |
| `api_jsonplaceholder` | `CREATE_POST_PAYLOAD`, `UPDATE_POST_PAYLOAD`, `PATCH_POST_PAYLOAD` | `api_test_data_config.json` |
| all | `DEFAULT_TIMEOUT` | `common_config.yml` |

### Usage

```powershell
# UI suites — pass suite name and region to config_loader
robot --variablefile config/config_loader.py:pta:QA          -d output --variable BROWSER:Chrome --variable HEADLESS:TRUE  tests/ui/pta/
robot --variablefile config/config_loader.py:heroku:STAGE    -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/heroku/
robot --variablefile config/config_loader.py:demo:PROD       -d output tests/ui/demo/

# API suite
robot --variablefile config/config_loader.py:api_jsonplaceholder:QA -d output tests/api/jsonplaceholder/
```

> **Supported suite values:** `pta` · `heroku` · `demo` · `api_jsonplaceholder`
>
> **Supported region values:** `DEV` · `QA` · `STAGE` · `PROD`
>
> **Security:** Add `config/ui/**/ui_test_data_config.yml` to `.gitignore`. Commit only the `.example` files. Teams copy and populate locally.

---

## 🌱 Variables

Three variables defined in `tests/ui/common/common.robot` control the browser, headless mode, and target environment. They are inherited by all suite `resource.robot` files via `Resource ../common/common.robot` and can be overridden at runtime via `--variable`.

### Variable Reference

| Variable           | Description                          | Default  | Accepted Values              | Required |
|--------------------|--------------------------------------|----------|------------------------------|:--------:|
| `BROWSER`          | Browser to launch                    | `Chrome` | `Chrome`, `Edge`, `Firefox`  | Optional |
| `HEADLESS`         | Run without a visible browser window | `TRUE`   | `TRUE`, `FALSE`              | Optional |
| `REGION`           | Target environment                   | `QA`     | `DEV`, `QA`, `STAGE`, `PROD` | Optional |
| `DEFAULT_TIMEOUT`  | Global element wait timeout (seconds)| `10`     | Any positive integer         | Optional |

> **Defined in:** `tests/ui/common/common.robot` — automatically inherited by all suites and page objects.
>
> Override at runtime — **no code changes needed**:
>
> ```powershell
> robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE --variable REGION:STAGE tests/ui/pta/
> ```

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
| `--variablefile <file>`             | Load variables from a Python or YAML file                            |
| `--loglevel <level>`                | Set log level (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`)            |
| `--dryrun`                          | Verify test syntax without executing                                  |
| `--rerunfailed <output.xml>`        | Re-run only failed test cases from a previous run                    |
| `--rerunfailedsuites <output.xml>`  | Re-run suites containing failed tests from a previous run            |
| `-P <path>` / `--pythonpath <path>` | Extra path(s) to add to Python's module search path                  |
| `--listener <class>`                | Register a listener class to receive execution events                |
| `--nostatusrc`                      | Always exit with code 0 (useful in CI to avoid pipeline failure)     |
| `-v` / `--variable`                 | Set a variable (shorthand form)                                       |

---

## 🧪 Running Tests

### Executor Scripts

The `executor/` folder contains ready-to-use `.bat` scripts for one-click test execution. Each script:

- Automatically navigates to the project root
- Deletes the `output/` folder if it exists (clean run)
- Launches the corresponding Robot Framework test suite

| Script                         | Suite              | Default Settings              |
|--------------------------------|--------------------|-------------------------------|
| `pta_ui_tests_executor.bat`    | `tests/ui/pta/`    | Chrome · Headless · QA region |
| `heroku_ui_tests_executor.bat` | `tests/ui/heroku/` | Chrome · Headless · QA region |
| `demo_ui_tests_executor.bat`   | `tests/ui/demo/`   | Chrome · Headful · QA region  |

**Execute from PowerShell (from any directory):**

```powershell
# Run PTA tests
.\executor\pta_ui_tests_executor.bat

# Run Heroku tests
.\executor\heroku_ui_tests_executor.bat

# Run Demo tests
.\executor\demo_ui_tests_executor.bat
```

> **Note:** The `BROWSER`, `HEADLESS`, and `REGION` defaults can be changed directly inside each `.bat` file — no other code changes needed.

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
robot --variablefile config/config_loader.py:pta:QA -d output tests/ui/pta/

# Chrome headful
robot --variablefile config/config_loader.py:pta:QA -d output --variable HEADLESS:FALSE tests/ui/pta/

# Firefox headless
robot --variablefile config/config_loader.py:pta:QA -d output --variable BROWSER:Firefox tests/ui/pta/

# Edge headful
robot --variablefile config/config_loader.py:pta:QA -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/pta/

# Run against STAGE environment
robot --variablefile config/config_loader.py:pta:STAGE -d output tests/ui/pta/
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
robot --variablefile config/config_loader.py:heroku:QA -d output tests/ui/heroku/

# Firefox headful
robot --variablefile config/config_loader.py:heroku:QA -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/heroku/

# Run against STAGE
robot --variablefile config/config_loader.py:heroku:STAGE -d output tests/ui/heroku/
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
robot --variablefile config/config_loader.py:demo:QA -d output tests/ui/demo/

# Run a single test case by name
robot --variablefile config/config_loader.py:demo:QA -d output --test "TC1 - Validate un-successful login" tests/ui/demo/test_demo.robot

# Run with Edge in headful mode
robot --variablefile config/config_loader.py:demo:QA -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/demo/

# Run against STAGE (uses real stage URL from ui_test_env_config.yml)
robot --variablefile config/config_loader.py:demo:STAGE -d output tests/ui/demo/
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
robot --variablefile config/config_loader.py:api_jsonplaceholder:QA -d output/api_test_run tests/api/

# Run against STAGE
robot --variablefile config/config_loader.py:api_jsonplaceholder:STAGE -d output/api_test_run tests/api/
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

#### Option 2 — Exclude with a Custom Tag

Tag individual tests with any meaningful label (e.g. `flaky`, `wip`, `manual`) and exclude that label:

```robot
TC7 - Select Option 1 from dropdown
    [Tags]    flaky
    ...
```

```powershell
robot -d output --exclude flaky tests/ui/heroku/
```

#### Option 3 — Run Only Specific Tests (`--include` / `--test`)

Instead of skipping, run only the tests you want:

```powershell
# Run only tests tagged 'smoke'
robot -d output --include smoke tests/ui/

# Run a single test by exact name
robot -d output --test "TC1 - Positive login with valid credentials" tests/ui/pta/test_pta.robot

# Run a specific suite only
robot -d output --suite test_heroku tests/ui/
```

#### Option 4 — `--skip` Flag (Robot Framework 5+)

Skip tests at runtime without tagging them in the file:

```powershell
# Skip by test name pattern
robot -d output --skip "TC3*" tests/ui/pta/

# Skip a specific test — marked SKIP instead of FAIL in the report
robot -d output --skip "TC5 - Negative login with both fields empty" tests/ui/pta/
```

> **Note:** Skipped tests appear in the report as **SKIP** (grey) — counted separately from PASS and FAIL.

#### Skipping Quick Reference

| Goal                          | Command                                                           |
|-------------------------------|-------------------------------------------------------------------|
| Skip tests tagged `skip`      | `robot -d output --exclude skip tests/ui/`                        |
| Skip tests tagged `flaky`     | `robot -d output --exclude flaky tests/ui/`                       |
| Run only tests tagged `smoke` | `robot -d output --include smoke tests/ui/`                       |
| Run one test by name          | `robot -d output --test "TC1 - ..." tests/ui/pta/test_pta.robot`  |
| Skip by name pattern (RF 5+)  | `robot -d output --skip "TC3*" tests/ui/pta/`                     |

---

### Parallel Execution (pabot)

[`robotframework-pabot`](https://pabot.org/) (v5.2.2) is included in `requirements.txt` and lets you run Robot Framework suites or test cases in parallel, significantly reducing overall execution time.

> **Important:** All `pabot` (and `robot`) commands below must be run from the **project root** (`Robot-Python-Automation-Framework/`), not from inside the `tests/` folder. Running from the wrong directory will cause a *"File or directory to execute does not exist"* error.

#### How pabot Works

pabot splits execution across multiple parallel processes. Each process runs a separate suite (or test) independently, then merges all results into a single `output.xml`, `log.html` and `report.html` at the end.

#### Run Suites in Parallel (Suite-Level — Default)

```powershell
# Run all UI suites in parallel
pabot -d output tests/ui/

# Specify the number of parallel processes
pabot --processes 3 -d output tests/ui/

# Run a specific suite in parallel
pabot -d output tests/ui/heroku/
```

#### Run Test Cases in Parallel (Test-Level)

```powershell
# Run all tests in parallel at test level
pabot --testlevelsplit -d output tests/ui/

# Run a single test file at test level
pabot --testlevelsplit -d output tests/ui/pta/test_pta.robot

# Combine with explicit process count
pabot --testlevelsplit --processes 4 -d output tests/ui/
```

> ⚠️ Use `--testlevelsplit` only when tests are fully independent (no shared state between test cases).

#### Pass Robot Framework Variables with pabot

All `robot` variable overrides work identically with `pabot`:

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
| Run one file at test level         | `pabot --testlevelsplit -d output tests/ui/pta/test_pta.robot`              |
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

      - name: Run Robot Framework tests
        run: robot -d output --variable BROWSER:Chrome --variable HEADLESS:TRUE tests/ui/

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
| `docs`     | Documentation-only changes                                              | `docs(readme): add running tests section`                          |
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
| `common`   | `tests/ui/common/common.robot` shared browser keyword file                 |
| `pta`      | PTA UI test suite (`tests/ui/pta/`)                                        |
| `heroku`   | The Internet Herokuapp UI test suite (`tests/ui/heroku/`)                  |
| `demo`     | Demo/learning tests (`tests/ui/demo/`)                                     |
| `pom`      | Page Object Model — `pages/` files across any suite                        |
| `config`   | `config/` folder — `config_loader.py`, YAML/JSON env & data config files   |
| `executor` | Batch executor scripts (`executor/`)                                       |
| `pabot`    | Parallel execution configuration and pabot-related changes                 |
| `ci`       | `.github/workflows/`, CI pipeline files                                    |
| `readme`   | `README.md`                                                                |

### Quick Examples

```text
feat(executor): add pta_ui_tests_executor.bat, heroku_ui_tests_executor.bat and demo_ui_tests_executor.bat with output cleanup

feat(demo): add test_demo.robot with login and shopping cart validation

feat(common): add multi-browser support with headless/headful mode for Chrome, Edge and Firefox

refactor(common): centralise browser setup into tests/ui/common/common.robot

feat(common): add DEFAULT_TIMEOUT variable for centralised element wait control

feat(pta): add logout and empty-field negative login test cases

feat(heroku): add checkboxes, dropdown and add/remove elements test cases

fix(demo): update card_titles locator to match updated DOM

chore(deps): bump robotframework-seleniumlibrary 6.7.0 → 6.8.0

chore(deps): add pyyaml==6.0.3 for config_loader.py YAML parsing

feat(pabot): add robotframework-pabot for parallel suite and test execution

refactor(pom): extract pta locators and keywords into pages/login_page.robot and pages/dashboard_page.robot

refactor(pom): extract heroku locators into pages/login_page, checkboxes_page, dropdown_page and add_remove_page

refactor(pom): extract demo locators and keywords into pages/login_page.robot and pages/shop_page.robot

feat(config): add config_loader.py with common_config.yml and per-suite YAML/JSON env and test data configs

refactor(config): remove hardcoded APP_URLS and credentials from all resource.robot files — inject via --variablefile

refactor(executor): update all .bat scripts to use --variablefile config/config_loader.py:<suite>:<region>

docs(readme): update variables section and running tests with multi-browser headless reference

test(heroku): add basic auth and broken images tests
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

