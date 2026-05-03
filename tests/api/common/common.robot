*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    OperatingSystem


*** Variables ***
${REGION}            %{REGION=QA}

# Common HTTP Status Codes
${STATUS_200}        200
${STATUS_201}        201
${STATUS_204}        204
${STATUS_400}        400
${STATUS_401}        401
${STATUS_403}        403
${STATUS_404}        404
${STATUS_500}        500

# Common Content Types
${CONTENT_TYPE_JSON}     application/json; charset=utf-8
${CONTENT_TYPE_JSON_SHORT}    application/json

# Default Timeout
${DEFAULT_TIMEOUT}    30


*** Keywords ***
Create API Session
    [Documentation]    Creates a requests session with a given alias and base URL.
    [Arguments]    ${alias}    ${base_url}    ${headers}=&{EMPTY}
    Create Session    ${alias}    ${base_url}    headers=${headers}    timeout=${DEFAULT_TIMEOUT}

Delete API Session
    [Documentation]    Deletes a requests session by alias.
    [Arguments]    ${alias}
    Delete All Sessions

Verify Status Code
    [Documentation]    Verifies the HTTP response status code.
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    ...    Expected status code ${expected_status}, but got ${response.status_code}

Verify Response Is List
    [Documentation]    Verifies the response body is a non-empty list.
    [Arguments]    ${response_json}
    Should Not Be Empty    ${response_json}    Response body list should not be empty

Verify Response Contains Fields
    [Documentation]    Verifies that a dictionary contains all required fields.
    [Arguments]    ${item}    @{required_fields}
    FOR    ${field}    IN    @{required_fields}
        Dictionary Should Contain Key    ${item}    ${field}
        ...    Response item is missing required field: ${field}
    END

Verify All Items Contain Fields
    [Documentation]    Verifies that all items in a list contain required fields.
    [Arguments]    ${items_list}    @{required_fields}
    FOR    ${item}    IN    @{items_list}
        Verify Response Contains Fields    ${item}    @{required_fields}
    END

Verify Field Value
    [Documentation]    Verifies that a field in a dict equals the expected value.
    [Arguments]    ${item}    ${field}    ${expected_value}
    ${actual_value}=    Get From Dictionary    ${item}    ${field}
    Should Be Equal    ${actual_value}    ${expected_value}
    ...    Expected ${field}=${expected_value}, but got ${actual_value}

Verify All Items Have Field Value
    [Documentation]    Verifies all items in a list have a field equal to a given value.
    [Arguments]    ${items_list}    ${field}    ${expected_value}
    FOR    ${item}    IN    @{items_list}
        Verify Field Value    ${item}    ${field}    ${expected_value}
    END

Verify Field Is Non Empty String
    [Documentation]    Verifies a given field in a dict is a non-empty string.
    [Arguments]    ${item}    ${field}
    ${value}=    Get From Dictionary    ${item}    ${field}
    Should Not Be Empty    ${value}    Field '${field}' should not be empty
    Should Be String    ${value}    Field '${field}' should be a string

Verify List Length
    [Documentation]    Verifies the list has an exact expected length.
    [Arguments]    ${items_list}    ${expected_length}
    ${length}=    Get Length    ${items_list}
    Should Be Equal As Integers    ${length}    ${expected_length}
    ...    Expected list length ${expected_length}, but got ${length}

Verify Response Body Is Empty Object
    [Documentation]    Verifies the JSON response body is an empty dictionary {}.
    [Arguments]    ${response_json}
    ${length}=    Get Length    ${response_json}
    Should Be Equal As Integers    ${length}    0
    ...    Expected empty response body {}, but got ${response_json}
