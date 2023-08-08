*** Settings ***
Documentation      A test suite that will verify external libraries and variables
...                Must pass in order for everything else to work as expected
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Library            RequestsLibrary
#Library            ${EXECDIR}/resources/libraries/GmailClient.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Force Tags         pretest
Suite Setup       Pre-Test: Verify BUI is Up


*** Variables ***

${inbox_object}
${microservice_url}    https://softico-dev-agent.frendsapp.com/api/qa/v1

*** Keywords ***
Pre-Test: Get BUI Status
    ${response}=    Get BUI Status
    IF    '${response}' == 'False'
        Fail    BUI is not up and running
    ELSE
        Log To Console    BUI is up and running
    END
    [Return]    ${response}

Pre-Test: Verify BUI is Up
    ${status}=     Pre-Test: Get BUI Status
    Should Be True    ${status}

*** Test Cases ***

Pre-Test: Get Config
    [Documentation]    Test case that checks the config file
    ${config}=    Get Config    ${url}
    Log To Console    Config for environment:
    Log To Console    ${config}

Pre-Test: Verify Variables are Set
    [Documentation]    Test case that verifies all environment variables are set 
    @{vars}=    Create List    ${inbox_id}      ${MUI_URL}    ${MUI_USERNAME}   ${MUI_PASSWORD}    ${MAILSLURP_API_KEY}
    FOR   ${var}    IN    @{vars}
        Should Not Be Empty    ${var}
    END

Pre-Test: Get Member Inbox
    [Documentation]        Verifies the Mailslurp keywords are running
    ${inbox}=    Get Inbox     ${inbox_id}
    Set Suite Variable    ${inbox_object}    ${inbox}
    Log To Console    ${inbox.name}
    ${i}=     Create new Inbox
    Log To Console     ${i}

Pre-Test: Verify API is Up
    Pass Execution     TBD: API is up and running

Pre-Test: Verify MUI is Up
    Pass Execution     TBD: MUI is up and running

Verify Rooms are Available
    Pass Execution    TBD: Check Rooms are available, for example API
