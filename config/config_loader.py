# pylint: disable=missing-module-docstring, missing-function-docstring, missing-class-docstring

"""
config_loader.py — Robot Framework variable file loader.

Loads environment URLs and test data from the config/ YAML/JSON files
and exposes them as Robot Framework variables.

Usage (via --variablefile):
    robot --variablefile config/config_loader.py           # defaults: suite=common, region=QA
    robot --variablefile config/config_loader.py:pta:QA    tests/ui/pta/
    robot --variablefile config/config_loader.py:heroku:STAGE  tests/ui/heroku/
    robot --variablefile config/config_loader.py:demo:PROD     tests/ui/demo/
    robot --variablefile config/config_loader.py:api_jsonplaceholder:QA  tests/api/

Supported suite values:
    pta                  → config/ui/pta/
    heroku               → config/ui/heroku/
    demo                 → config/ui/demo/
    api_jsonplaceholder  → config/api/jsonplaceholder/
"""

import json
import os

import yaml

# Absolute path to this config/ directory
_CONFIG_DIR = os.path.dirname(os.path.abspath(__file__))

# Registry: suite name → (env config path, data config path)
_SUITE_CONFIGS = {
    "pta": (
        "ui/pta/ui_test_env_config.yml",
        "ui/pta/ui_test_data_config.yml",
    ),
    "heroku": (
        "ui/heroku/ui_test_env_config.yml",
        "ui/heroku/ui_test_data_config.yml",
    ),
    "demo": (
        "ui/demo/ui_test_env_config.yml",
        "ui/demo/ui_test_data_config.yml",
    ),
    "api_jsonplaceholder": (
        "api/jsonplaceholder/api_test_env_config.yml",
        "api/jsonplaceholder/api_test_data_config.json",
    ),
}


def _load_yaml(rel_path: str) -> dict:
    abs_path = os.path.join(_CONFIG_DIR, rel_path)
    with open(abs_path, encoding="utf-8") as fh:
        return yaml.safe_load(fh) or {}


def _load_json(rel_path: str) -> dict:
    abs_path = os.path.join(_CONFIG_DIR, rel_path)
    with open(abs_path, encoding="utf-8") as fh:
        return json.load(fh)


def _load_data(rel_path: str) -> dict:
    """Load YAML or JSON based on file extension."""
    _, ext = os.path.splitext(rel_path)
    if ext == ".json":
        return _load_json(rel_path)
    return _load_yaml(rel_path)


def get_variables(suite: str = "pta", region: str = "QA") -> dict:
    """
    Called by Robot Framework when this file is used as a --variablefile.

    Returns a flat dict of Robot Framework variables for the requested
    suite and region. Variable names use UPPER_SNAKE_CASE to follow
    Robot Framework conventions.

    :param suite:  One of the keys in _SUITE_CONFIGS (e.g. 'pta', 'heroku').
    :param region: Environment region key (DEV, QA, STAGE, PROD).
    :return:       Dict of {VARIABLE_NAME: value} pairs.
    """
    region = region.upper()
    suite = suite.lower()

    if suite not in _SUITE_CONFIGS:
        raise ValueError(
            f"Unknown suite '{suite}'. "
            f"Valid values: {', '.join(_SUITE_CONFIGS.keys())}"
        )

    env_path, data_path = _SUITE_CONFIGS[suite]

    # --- common config ---
    common = _load_yaml("common_config.yml")

    # --- environment config ---
    env_all = _load_yaml(env_path)
    if region not in env_all:
        raise ValueError(
            f"Region '{region}' not found in '{env_path}'. "
            f"Available regions: {', '.join(env_all.keys())}"
        )
    env = env_all[region]

    # --- test data config ---
    data = _load_data(data_path)

    # --- build variable dict ---
    variables = {
        # Common
        "DEFAULT_TIMEOUT": common.get("default_timeout", 10),
    }

    # UI suites — env provides 'url', data provides credentials
    if suite in ("pta", "heroku", "demo"):
        variables.update({
            "APP_URL":          env.get("url", ""),
            "VALID_USERNAME":   data.get("valid_username", ""),
            "VALID_PASSWORD":   data.get("valid_password", ""),
            "INVALID_USERNAME": data.get("invalid_username", ""),
            "INVALID_PASSWORD": data.get("invalid_password", ""),
        })
        if suite == "demo":
            variables["CARD_NAME"] = data.get("card_name", "")

    # API suite — env provides 'base_url', data provides request payloads
    elif suite == "api_jsonplaceholder":
        variables.update({
            "JSONPLACEHOLDER_BASE_URL": env.get("base_url", ""),
            "CREATE_POST_PAYLOAD":      data.get("CreatePost", {}),
            "UPDATE_POST_PAYLOAD":      data.get("UpdatePost", {}),
            "PATCH_POST_PAYLOAD":       data.get("PatchPost", {}),
            "CREATE_COMMENT_PAYLOAD":   data.get("CreateComment", {}),
        })

    return variables
