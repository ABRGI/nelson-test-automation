*** Settings ***
Documentation      A test suite that will verify external libraries and variables
...                Must pass in order for everything else to work as expected
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Library            ${EXECDIR}/resources/libraries/GmailClient.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Force Tags         pretest

*** Variables ***

${inbox_object}
${microservice_url}    https://softico-dev-agent.frendsapp.com/api/qa/v1

*** Test Cases ***

Pre-Test: Check Gmail
    ${e}=     Get Latest Email Id By Subject
    Log To Console     Latest email content:
    Log To Console     ${e}

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

Pre-Test: Verify BUI is Up
    Pass Execution     TBD: BUI is up and runnin

Pre-Test: Verify API is Up
    Pass Execution     TBD: API is up and running

Pre-Test: Verify MUI is Up
    Pass Execution     TBD: MUI is up and running

Verify Rooms are Available
    Pass Execution    TBD: Check Rooms are available, for example API
