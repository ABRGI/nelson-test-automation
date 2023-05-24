*** Settings ***
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Library            Browser     auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Test Tags          MUI-424

*** Test Cases ***

Create A New Booking
    [Documentation]    A new booker opens the page and does a successful booking
    Open Browser to Landing Page 
    Select Hotel    Vaasa
    Choose Dates and Guests 
    Select Room and Extras
    Fill in Payment Details     
    Simulate Success or Failure    success

Confirm Email
    [Documentation]     A new booker receives an email with a link to modify the booking 
    Pass Execution      TBD in: BUI2-562   
    Get Link from Email

Open Link
    Pass Execution    TBD 



