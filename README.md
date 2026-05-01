<!-- markdownlint-disable MD033 MD041 -->
<div align="center">

# 🤖 Robot-Python-Automation-Framework

**A scalable, maintainable test automation framework for UI testing using Robot Framework.**

Built with Python · Robot Framework · SeleniumLibrary
Cross-browser UI Testing · Keyword-Driven & Data-Driven Testing · CI/CD Ready

</div>

---

## 📑 Table of Contents

1. [Features](#-features)
2. [Quick Start](#-quick-start)
3. [Project Structure](#-project-structure)
4. [Variables](#-variables)
5. [Robot Framework CLI Reference](#-robot-framework-cli-reference)
6. [Running Tests](#-running-tests)
   - [Executor Scripts](#executor-scripts)
   - [UI · PTA](#ui--pta)
   - [UI · Heroku](#ui--heroku)
   - [UI · Demo](#ui--demo)
   - [Browser & Headless Mode Quick Reference](#browser--headless-mode-quick-reference)
7. [Reports](#-reports)
   - [Built-in Robot Report](#built-in-robot-report)
8. [CI/CD Integration](#-cicd-integration)
   - [GitHub Actions](#-github-actions)
9. [Conventional Commits](#-conventional-commits)
10. [MCP Servers](#-mcp-servers)

---

## ✨ Features

| #  | Feature                                                                                      | Status |
|----|----------------------------------------------------------------------------------------------|:------:|
| 1  | 🤖 Robot Framework · Python · SeleniumLibrary test automation                                | ✅     |
| 2  | 🔧 Python programming support                                                                 | ✅     |
| 3  | 🌐 Cross-browser UI testing (Chrome, Firefox, Edge) — headless & headful                     | ✅     |
| 4  | 📝 Keyword-Driven Testing (KDT) with reusable `.robot` resource files                        | ✅     |
| 5  | 📊 Built-in HTML log, report and XML output                                                   | ✅     |
| 6  | 🗂️ Resource files for shared keywords and variables                                          | ✅     |
| 7  | 🧪 Data-driven testing with Robot Framework variables                                         | ✅     |
| 8  | 🔁 Test Setup & Teardown for browser lifecycle management                                     | ✅     |
| 9  | 🧩 Reusable demo tests for validation and learning                                            | ✅     |
| 10 | ⚙️ Runtime `--variable` overrides for `BROWSER`, `HEADLESS` and `REGION` — no code changes needed | ✅ |
| 11 | 🌍 Multi-environment support via `REGION` variable (`DEV`, `QA`, `STAGE`, `PROD`)            | ✅     |
| 12 | 🔗 Centralised browser setup in `tests/ui/common/browser.robot`                              | ✅     |

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

```bash
# Runs in Chrome headless mode by default (QA environment)
robot -d output tests/ui/heroku/test_heroku.robot
```

### 5. View the report

- Open `output/report.html` in a browser, **or**
- Open `output/log.html` for a detailed execution log.

---

## 🚀 Project Structure

```text
Robot-Python-Automation-Framework/
│
├── output/                                        # Auto-generated test artifacts
│   ├── log.html                                   # Detailed Robot Framework execution log
│   ├── output.xml                                 # Raw XML results
│   └── report.html                                # Robot Framework HTML summary report
│
├── executor/                                      # Batch scripts for one-click test execution
│   ├── pta_ui_tests_executor.bat                  # Cleans output & runs PTA UI tests
│   └── heroku_ui_tests_executor.bat               # Cleans output & runs Heroku UI tests
│
├── tests/                                         # Test suite root
│   └── ui/                                        # UI test suites
│       ├── common/
│       │   └── browser.robot                      # Shared browser launch & teardown keywords
│       │
│       ├── demo/                                  # Demo / learning tests (rahulshettyacademy)
│       │   ├── resource.robot                     # Demo-specific keywords, variables & URLs
│       │   └── test_demo.robot                    # Login validation + shopping cart tests
│       │
│       ├── heroku/                                # The Internet Herokuapp UI tests
│       │   ├── resource.robot                     # Heroku-specific keywords, variables & URLs
│       │   └── test_heroku.robot                  # Login, checkboxes, dropdown, add/remove elements
│       │
│       └── pta/                                   # Practice Test Automation (PTA) UI tests
│           ├── resource.robot                     # PTA-specific keywords, variables & URLs
│           └── test_pta.robot                     # Login positive/negative + logout tests
│
├── .gitignore
├── README.md
└── requirements.txt
```

---

## 🌱 Variables

Three variables in each suite's `resource.robot` control the browser, headless mode, and target environment. They have defaults and can be overridden at runtime via `--variable`.

### UI Testing

| Variable   | Description                                              | Default  | Accepted Values                      | Required |
|------------|----------------------------------------------------------|----------|--------------------------------------|:--------:|
| `BROWSER`  | Browser to launch                                        | `Chrome` | `Chrome`, `Edge`, `Firefox`          | Optional |
| `HEADLESS` | Run without a visible browser window                     | `TRUE`   | `TRUE`, `FALSE`                      | Optional |
| `REGION`   | Target environment                                       | `QA`     | `DEV`, `QA`, `STAGE`, `PROD`         | Optional |

> Override at runtime — **no code changes needed**:
> ```powershell
> robot --variable BROWSER:Firefox --variable HEADLESS:FALSE --variable REGION:STAGE tests/ui/pta/
> ```

### How headless mode works per browser

| Browser | Headless arguments applied                                      |
|---------|-----------------------------------------------------------------|
| Chrome  | `--headless=new`, `--disable-gpu`, `--window-size=1920,1080`   |
| Edge    | `--headless=new`, `--disable-gpu`, `--window-size=1920,1080`   |
| Firefox | `--headless`, `--width=1920`, `--height=1080`                  |

> If an unsupported browser name is passed, the test fails immediately with a clear message:
> `Unsupported browser '<value>'. Supported values: Chrome, Edge, Firefox.`

---

## 🚩 Robot Framework CLI Reference

| Flag / Option                        | Description                                                                 |
|--------------------------------------|-----------------------------------------------------------------------------|
| `-d <dir>` / `--outputdir <dir>`     | Directory for output files (`log.html`, `report.html`, `output.xml`)        |
| `-o <file>` / `--output <file>`      | Output XML file name (default: `output.xml`)                                |
| `-l <file>` / `--log <file>`         | Log file name (default: `log.html`)                                         |
| `-r <file>` / `--report <file>`      | Report file name (default: `report.html`)                                   |
| `-i <tag>` / `--include <tag>`       | Run only tests with matching tag (e.g. `--include smoke`)                   |
| `-e <tag>` / `--exclude <tag>`       | Exclude tests with matching tag                                              |
| `-t <name>` / `--test <name>`        | Run a specific test case by name                                             |
| `-s <name>` / `--suite <name>`       | Run a specific test suite by name                                            |
| `--variable <name>:<value>`          | Override a variable at runtime (e.g. `--variable BROWSER:Firefox`)          |
| `--variablefile <file>`              | Load variables from a Python or YAML file                                   |
| `--loglevel <level>`                 | Set log level (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`)                   |
| `--dryrun`                           | Verify test syntax without executing                                        |
| `--rerunfailed <output.xml>`         | Re-run only failed test cases from a previous run                           |
| `--rerunfailedsuites <output.xml>`   | Re-run suites containing failed tests from a previous run                   |
| `-P <path>` / `--pythonpath <path>`  | Extra path(s) to add to Python's module search path                         |
| `--listener <class>`                 | Register a listener class to receive execution events                       |
| `--nostatusrc`                       | Always exit with code 0 (useful in CI to avoid pipeline failure)            |
| `-v` / `--variable`                  | Set a variable (shorthand form)                                             |

---

## 🧪 Running Tests

### Executor Scripts

The `executor/` folder contains ready-to-use `.bat` scripts for one-click test execution. Each script:

- Automatically navigates to the project root
- Deletes the `output/` folder if it exists (clean run)
- Launches the corresponding Robot Framework test suite

| Script                        | Suite          | Default Settings                  |
|-------------------------------|----------------|-----------------------------------|
| `pta_ui_tests_executor.bat`   | `tests/ui/pta/`    | Chrome · Headless · QA region |
| `heroku_ui_tests_executor.bat`| `tests/ui/heroku/` | Chrome · Headless · QA region |

**Execute from PowerShell (from any directory):**

```powershell
# Run PTA tests
.\executor\pta_ui_tests_executor.bat

# Run Heroku tests
.\executor\heroku_ui_tests_executor.bat
```

> The `BROWSER`, `HEADLESS`, and `REGION` defaults can be changed directly inside each `.bat` file — no other code changes needed.

---

### UI · PTA

Tests cover login (positive & negative), logout, and empty-field validation against [practicetestautomation.com](https://practicetestautomation.com/practice-test-login/).

| Test Case | Description                                      |
|-----------|--------------------------------------------------|
| TC1       | Positive login with valid credentials            |
| TC2       | Negative login with invalid username             |
| TC3       | Negative login with invalid password             |
| TC4       | Verify logout after successful login             |
| TC5       | Negative login with both fields empty            |

```powershell
# Chrome headless (default)
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

### UI · Heroku

Tests cover form authentication, checkboxes, dropdown, and add/remove elements against [the-internet.herokuapp.com](https://the-internet.herokuapp.com/).

| Test Case | Area                | Description                                      |
|-----------|---------------------|--------------------------------------------------|
| TC1       | Form Authentication | Successful login with valid credentials          |
| TC2       | Form Authentication | Unsuccessful login with invalid username         |
| TC3       | Form Authentication | Unsuccessful login with invalid password         |
| TC4       | Form Authentication | Logout after successful login                    |
| TC5       | Checkboxes          | Check checkbox 1 and verify it is selected       |
| TC6       | Checkboxes          | Uncheck checkbox 2 and verify it is deselected   |
| TC7       | Dropdown            | Select Option 1 from dropdown                    |
| TC8       | Dropdown            | Select Option 2 from dropdown                    |
| TC9       | Add / Remove        | Add an element and verify it appears             |
| TC10      | Add / Remove        | Add multiple elements and verify count           |
| TC11      | Add / Remove        | Add then delete an element                       |

```powershell
# Chrome headless (default)
robot -d output tests/ui/heroku/

# Firefox headful
robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/heroku/
```

### UI · Demo

Tests cover login validation and shopping cart card verification against [rahulshettyacademy.com](https://rahulshettyacademy.com/loginpagePractise).

| Test Case | Description                                      |
|-----------|--------------------------------------------------|
| TC1       | Validate un-successful login                     |
| TC2       | Validate cards display in the shopping page      |

```powershell
# Run all tests in the demo suite (Chrome headless by default)
robot -d output tests/ui/demo/

# Run a single test case by name
robot -d output --test "TC1 - Validate un-successful login" tests/ui/demo/test_demo.robot

# Run with Edge in headful mode
robot -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/demo/
```

Re-run only failed tests from the last run:

```powershell
robot -d output --rerunfailed output/output.xml tests/
```

### Browser & Headless mode quick reference

| Browser | Mode     | Command                                                                          |
|---------|----------|----------------------------------------------------------------------------------|
| Chrome  | Headless | `robot -d output tests/ui/`                                                      |
| Chrome  | Headful  | `robot -d output --variable HEADLESS:FALSE tests/ui/`                            |
| Edge    | Headless | `robot -d output --variable BROWSER:Edge tests/ui/`                              |
| Edge    | Headful  | `robot -d output --variable BROWSER:Edge --variable HEADLESS:FALSE tests/ui/`    |
| Firefox | Headless | `robot -d output --variable BROWSER:Firefox tests/ui/`                           |
| Firefox | Headful  | `robot -d output --variable BROWSER:Firefox --variable HEADLESS:FALSE tests/ui/` |

---

## 📊 Reports

### Built-in Robot Report

Robot Framework automatically generates three output files after every run (in the directory specified by `-d`):

| File           | Description                                                          |
|----------------|----------------------------------------------------------------------|
| `report.html`  | High-level summary — pass/fail counts, suite statistics, tag report  |
| `log.html`     | Detailed interactive log — every keyword call, argument and result   |
| `output.xml`   | Machine-readable XML — used for re-runs and CI integrations          |

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

The pipeline can be configured to trigger automatically when changes are pushed or merged to `main`.

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

**Viewing results**

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

### Type prefixes

| Prefix     | When to use                                                                       | Example                                                          |
|------------|-----------------------------------------------------------------------------------|------------------------------------------------------------------|
| `feat`     | A new feature                                                                     | `feat(pta): add login validation test`                           |
| `fix`      | A bug fix                                                                         | `fix(heroku): correct login locator selector`                    |
| `chore`    | Routine tasks, dependency updates, tooling — no production logic change           | `chore(deps): bump robotframework 7.4.1 → 7.4.2`                |
| `docs`     | Documentation-only changes                                                        | `docs(readme): add running tests section`                        |
| `style`    | Formatting, whitespace — no logic change                                          | `style: reformat resource.robot keywords`                        |
| `refactor` | Code restructured without fixing a bug or adding a feature                        | `refactor(common): extract browser setup into common/browser.robot` |
| `test`     | Adding or updating tests                                                          | `test(heroku): add add-remove elements test`                     |
| `ci`       | Changes to CI/CD pipeline files                                                   | `ci: add GitHub Actions Robot Framework workflow`                |
| `build`    | Changes affecting the build system or external dependencies                       | `build: upgrade to Python 3.13`                                  |
| `revert`   | Reverts a previous commit                                                         | `revert: revert "feat(pta): add login test"`                     |

### Scopes

| Scope      | Refers to                                                         |
|------------|-------------------------------------------------------------------|
| `deps`     | `requirements.txt` dependency changes                             |
| `common`   | `tests/ui/common/browser.robot` shared browser keyword file       |
| `pta`      | PTA UI test suite (`tests/ui/pta/`)                               |
| `heroku`   | The Internet Herokuapp UI test suite (`tests/ui/heroku/`)         |
| `demo`     | Demo/learning tests (`tests/ui/demo/`)                            |
| `executor` | Batch executor scripts (`executor/`)                              |
| `ci`       | `.github/workflows/`, CI pipeline files                           |
| `readme`   | `README.md`                                                       |

### Quick examples used in this project

```text
feat(executor): add pta_ui_tests_executor.bat and heroku_ui_tests_executor.bat with output cleanup

feat(demo): add test_demo.robot with login and shopping cart validation

feat(common): add multi-browser support with headless/headful mode for Chrome, Edge and Firefox

refactor(common): centralise browser setup into tests/ui/common/browser.robot

feat(pta): add logout and empty-field negative login test cases

feat(heroku): add checkboxes, dropdown and add/remove elements test cases

fix(demo): update card_titles locator to match updated DOM

chore(deps): bump robotframework-seleniumlibrary 6.7.0 → 6.8.0

docs(readme): update variables section and running tests with multi-browser headless reference

test(heroku): add basic auth and broken images tests
```

---

## 🤖 MCP Servers

This project uses [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) servers to extend GitHub Copilot with browser automation, filesystem access, REST API testing and more.

The configuration file lives at:

```text
%LOCALAPPDATA%\github-copilot\intellij\mcp.json
```

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
    "rest-api": {
      "command": "node",
      "args": [
        "C:\\Users\\<your-username>\\AppData\\Roaming\\npm\\node_modules\\dkmaker-mcp-rest-api\\build\\index.js"
      ],
      "env": {
        "REST_BASE_URL": "https://rahulshettyacademy.com/",
        "HEADER_Accept": "application/json"
      }
    }
  }
}
```

### MCP server reference

| Server       | Package                                           | Purpose                                                              |
|--------------|---------------------------------------------------|----------------------------------------------------------------------|
| `github`     | GitHub Copilot MCP (remote)                       | GitHub repo, PR, issue, and search management                        |
| `playwright` | `@playwright/mcp@latest`                          | Browser automation — navigate, click, screenshot, snapshot           |
| `selenium`   | `@angiejones/mcp-selenium`                        | Selenium WebDriver interactions for browser testing                  |
| `filesystem` | `@modelcontextprotocol/server-filesystem`         | Read/write files within allowed local directories                    |
| `rest-api`   | `dkmaker-mcp-rest-api`                            | Test REST API endpoints (base URL: `https://rahulshettyacademy.com/`)|

### Prerequisites

```bash
# Node.js (for npx-based servers)
node --version   # v18+ recommended

# Install the REST API MCP server globally
npm install -g dkmaker-mcp-rest-api
```

> Replace `<your-username>` in the paths above with your actual Windows username before using the config.

---

<div align="center">

### 🤖 Happy Testing! 🤖

</div>

