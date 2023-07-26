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
${microservice_url}    https://softico-dev-agent.frendsapp.com/api/qa/v1

*** Test Cases ***

Pre-Test: Verify Variables are Set
    [Documentation]    Test case that verifies all environment variables are set 
    @{vars}=    Create List    ${inbox_id}      ${MUI_URL}    ${MUI_USERNAME}    ${MUI_PASSWORD}    ${MAILSLURP_API_KEY}
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

    # AKITA_API_KEY=apk_3LRdkFdLrfQWZ8eeD3I2qU
    # AKITA_API_SECRET=08ec4b86ab751f041a28e3dafac9d609ddec7b2ec3b6a197102333e8dfd633c8