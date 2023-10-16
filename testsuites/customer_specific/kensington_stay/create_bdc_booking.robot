
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/EC.resource
Resource          ${EXECDIR}/resources/keywords/bdc.resource

Library            Browser         auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Force Tags        kensington_stay

*** Test Cases *** 

Open BDC and Check for Availability
    Open Booking.com to KS Test
    Check Availability for Today

Start Reservation Process
    Click Reserve Button to Start
    Select Number of Rooms and Reserve

Fill Contact Information and Payment Details
    ${id}=         Get Inbox ID
    Fill Contact Information in BDC
    Fill in Card Details
    Click BDC Book Button

Verify Confirmation Email
    Verify Emails and Set Booking No