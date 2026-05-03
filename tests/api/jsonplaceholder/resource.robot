*** Settings ***
Documentation    Resource file for the JSONPlaceholder API suite.
...
...              Base URL is loaded from config/api/jsonplaceholder/api_test_env_config.yml
...              Request payloads are loaded from config/api/jsonplaceholder/api_test_data_config.json
...              Both are injected via --variablefile config/config_loader.py:api_jsonplaceholder:<REGION>
Library    RequestsLibrary
Library    Collections
Resource   ../common/common.robot


*** Variables ***
${JSONPLACEHOLDER_SESSION}      jsonplaceholder

# Endpoints
${ENDPOINT_POSTS}               /posts
${ENDPOINT_POSTS_1}             /posts/1
${ENDPOINT_POSTS_1_COMMENTS}    /posts/1/comments
${ENDPOINT_USERS}               /users
${ENDPOINT_USERS_1_TODOS}       /users/1/todos

# Expected Fields
@{POST_REQUIRED_FIELDS}         id    title    body    userId
@{COMMENT_REQUIRED_FIELDS}      id    postId    name    email    body
@{USER_REQUIRED_FIELDS}         id    name    username    email    address    phone    website    company
@{TODO_REQUIRED_FIELDS}         id    userId    title    completed

# Expected counts
${EXPECTED_USERS_COUNT}         ${10}


*** Keywords ***
Open JSONPlaceholder Session
    [Documentation]    Creates a session for JSONPlaceholder API using JSONPLACEHOLDER_BASE_URL injected by config_loader.py.
    Create API Session    ${JSONPLACEHOLDER_SESSION}    ${JSONPLACEHOLDER_BASE_URL}

Close JSONPlaceholder Session
    [Documentation]    Closes the JSONPlaceholder API session.
    Delete All Sessions

Send GET Request
    [Documentation]    Sends a GET request and returns the response.
    [Arguments]    ${endpoint}
    ${response}=    GET On Session    ${JSONPLACEHOLDER_SESSION}    ${endpoint}    expected_status=any
    RETURN    ${response}

Send POST Request
    [Documentation]    Sends a POST request with a JSON body and returns the response.
    [Arguments]    ${endpoint}    ${payload}
    ${response}=    POST On Session    ${JSONPLACEHOLDER_SESSION}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${response}

Send PUT Request
    [Documentation]    Sends a PUT request with a JSON body and returns the response.
    [Arguments]    ${endpoint}    ${payload}
    ${response}=    PUT On Session    ${JSONPLACEHOLDER_SESSION}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${response}

Send PATCH Request
    [Documentation]    Sends a PATCH request with a JSON body and returns the response.
    [Arguments]    ${endpoint}    ${payload}
    ${response}=    PATCH On Session    ${JSONPLACEHOLDER_SESSION}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${response}

Send DELETE Request
    [Documentation]    Sends a DELETE request and returns the response.
    [Arguments]    ${endpoint}
    ${response}=    DELETE On Session    ${JSONPLACEHOLDER_SESSION}    ${endpoint}    expected_status=any
    RETURN    ${response}
