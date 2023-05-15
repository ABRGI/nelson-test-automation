*** Settings ***
Documentation     A test suite for easy development and testing
Library           ${EXECDIR}/resources/libraries/Gmail.py
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource

*** Test Cases ***
Get Latest Confirmation Email
    [Documentation]    Example on how to use the Gmail library
    ${link}=    Get Link    MANAGE    Booking confirmation
    Log To Console    ${link}
