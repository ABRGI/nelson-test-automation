*** Settings ***
Documentation      A test suite that will verify external libraries and variables
...                Must pass in order for everything else to work as expected
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Force Tags         pretest


*** Variables ***

${inbox_object}

*** Test Cases ***

Pre-Test: Get Non-Member Inbox
    [Documentation]        Verifies the Mailslurp keywords are running
    ${inbox}=    Create new Inbox
    Set Suite Variable    ${inboxId}    ${inbox.id}
    Log To Console    ${inbox_id}

Pre-Test: Get Member Inbox
    [Documentation]        Verifies the Mailslurp keywords are running
    Log To Console    ${inbox_id}
    ${inbox}=    Get Inbox     ${inbox_id}
    Set Suite Variable    ${inbox_object}    ${inbox}
    Log To Console    ${inbox.name}

Pre-Test: Verify Variables are Set
    @{vars}=    Create List    ${inbox_id}    ${MAILSLURP_API_KEY}       ${MUI_URL}    ${MUI_USERNAME}    ${MUI_PASSWORD}    ${MUI_URL}    ${MUI_USERNAME}    ${MUI_PASSWORD}   
    FOR   ${var}    IN    @{vars}
        Should Not Be Empty    ${var}
    END

Pre-Test: Verify BUI is Up
    Pass Execution     TBD: BUI is up and running

Pre-Test: Verify API is Up
    Pass Execution     TBD: API is up and running

Pre-Test: Verify MUI is Up
    Pass Execution     TBD: MUI is up and running

Verify Rooms are Available
    Pass Execution    TBD: Check Rooms are available, for example API