
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/bdc.resource
Documentation      A test suite for verifying BDC booking functionality
Force Tags         staging, omena, bdc, smoke

*** Test Cases *** 

Open BDC and Check for Availability
    Open New Browser To URL    ${url.bdc.test.omena}
    Check Availability for Today

Create Reservation in BDC
    Verify Book Button is Visible
    Select Room Type 
    Click I'll Reserve

Fill Contact Information and Payment Details
    ${id}=         Get Inbox ID
    Fill Contact Information in BDC
    Fill in Card Details
    Click BDC Book Button

Verify Confirmation Email Arrives
    Verify Emails and Set Booking No