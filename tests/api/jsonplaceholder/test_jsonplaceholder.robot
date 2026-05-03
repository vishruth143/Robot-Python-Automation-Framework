*** Settings ***
Documentation    JSONPlaceholder API Test Suite
...              https://jsonplaceholder.typicode.com
Test Tags        jsonplaceholder
Suite Setup      Open JSONPlaceholder Session
Suite Teardown   Close JSONPlaceholder Session
Library          RequestsLibrary
Library          Collections
Resource         ../common/common.robot
Resource         resource.robot


*** Test Cases ***
TC1 - GET /posts returns a list of posts
    ${response}=    Send GET Request    ${ENDPOINT_POSTS}
    Verify Status Code    ${response}    ${STATUS_200}
    ${posts}=    Set Variable    ${response.json()}
    Verify Response Is List    ${posts}
    Verify All Items Contain Fields    ${posts}    @{POST_REQUIRED_FIELDS}

TC2 - GET /posts/1 returns the correct post
    ${response}=    Send GET Request    ${ENDPOINT_POSTS_1}
    Verify Status Code    ${response}    ${STATUS_200}
    ${post}=    Set Variable    ${response.json()}
    Verify Field Value    ${post}    id    ${1}
    Verify Field Value    ${post}    userId    ${1}
    Verify Field Is Non Empty String    ${post}    title
    Verify Field Is Non Empty String    ${post}    body

TC3 - POST /posts creates a new post
    ${response}=    Send POST Request    ${ENDPOINT_POSTS}    ${CREATE_POST_PAYLOAD}
    Verify Status Code    ${response}    ${STATUS_201}
    ${data}=    Set Variable    ${response.json()}
    Verify Field Value    ${data}    title    foo
    Verify Field Value    ${data}    body    bar
    Verify Field Value    ${data}    userId    ${1}
    Dictionary Should Contain Key    ${data}    id

TC4 - PUT /posts/1 fully updates a post
    ${response}=    Send PUT Request    ${ENDPOINT_POSTS_1}    ${UPDATE_POST_PAYLOAD}
    Verify Status Code    ${response}    ${STATUS_200}
    ${data}=    Set Variable    ${response.json()}
    Verify Field Value    ${data}    id    ${1}
    Verify Field Value    ${data}    title    updated title
    Verify Field Value    ${data}    body    updated body
    Verify Field Value    ${data}    userId    ${1}

TC5 - PATCH /posts/1 partially updates a post
    ${response}=    Send PATCH Request    ${ENDPOINT_POSTS_1}    ${PATCH_POST_PAYLOAD}
    Verify Status Code    ${response}    ${STATUS_200}
    ${data}=    Set Variable    ${response.json()}
    Verify Field Value    ${data}    title    patched title

TC6 - DELETE /posts/1 deletes a post
    ${response}=    Send DELETE Request    ${ENDPOINT_POSTS_1}
    Verify Status Code    ${response}    ${STATUS_200}
    ${data}=    Set Variable    ${response.json()}
    Verify Response Body Is Empty Object    ${data}

TC7 - GET /posts/1/comments returns comments for post 1
    ${response}=    Send GET Request    ${ENDPOINT_POSTS_1_COMMENTS}
    Verify Status Code    ${response}    ${STATUS_200}
    ${comments}=    Set Variable    ${response.json()}
    Verify Response Is List    ${comments}
    Verify All Items Contain Fields    ${comments}    @{COMMENT_REQUIRED_FIELDS}
    Verify All Items Have Field Value    ${comments}    postId    ${1}

TC8 - GET /users returns a list of 10 users
    ${response}=    Send GET Request    ${ENDPOINT_USERS}
    Verify Status Code    ${response}    ${STATUS_200}
    ${users}=    Set Variable    ${response.json()}
    Verify List Length    ${users}    ${EXPECTED_USERS_COUNT}
    Verify All Items Contain Fields    ${users}    @{USER_REQUIRED_FIELDS}

TC9 - GET /users/1/todos returns todos for user 1
    ${response}=    Send GET Request    ${ENDPOINT_USERS_1_TODOS}
    Verify Status Code    ${response}    ${STATUS_200}
    ${todos}=    Set Variable    ${response.json()}
    Verify Response Is List    ${todos}
    Verify All Items Contain Fields    ${todos}    @{TODO_REQUIRED_FIELDS}
    Verify All Items Have Field Value    ${todos}    userId    ${1}
