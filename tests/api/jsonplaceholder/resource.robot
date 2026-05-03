*** Settings ***
Documentation    Resource file for the JSONPlaceholder API suite.
...              Base URLs and request payloads are defined below as variables.
...              REGION (DEV/QA/STAGE/PROD) is resolved at runtime via common.robot,
...              defaulting to QA.
Library    RequestsLibrary
Library    Collections
Resource   ../common/common.robot


*** Variables ***
# Base URLs per region
&{JSONPLACEHOLDER_URLS}
...    DEV=https://jsonplaceholder.typicode.com
...    QA=https://jsonplaceholder.typicode.com
...    STAGE=https://jsonplaceholder.typicode.com
...    PROD=https://jsonplaceholder.typicode.com

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

# Request payloads
&{CREATE_POST_PAYLOAD}          title=foo    body=bar    userId=${1}
&{UPDATE_POST_PAYLOAD}          id=${1}    title=updated title    body=updated body    userId=${1}
&{PATCH_POST_PAYLOAD}           title=patched title
&{CREATE_COMMENT_PAYLOAD}       postId=${1}    name=test comment    email=test@example.com    body=This is a test comment.


*** Keywords ***
Open JSONPlaceholder Session
    [Documentation]    Creates a session for JSONPlaceholder API using the URL for REGION.
    ${BASE_URL}=    Get From Dictionary    ${JSONPLACEHOLDER_URLS}    ${REGION}
    Create API Session    ${JSONPLACEHOLDER_SESSION}    ${BASE_URL}

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
