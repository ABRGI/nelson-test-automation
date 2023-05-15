
*** Settings ***
Library            ${EXECDIR}/resources/libraries/Gmail.py
Library            ${EXECDIR}/resources/libraries/Helpers.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A test suite for easy development and testing



*** Test Cases ***

Get Latest Confirmation Email    
    [Documentation]      Example on how to use the Gmail library  
    ${link}=             Gmail.Get Link      MANAGE          Booking confirmation
    Log To Console       ${link}

