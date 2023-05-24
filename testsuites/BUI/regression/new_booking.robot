*** Settings ***
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Library            Browser     auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality

*** Test Cases ***

Create A New Booking
    [Documentation]    A new booker opens the page and does a successful booking
    Open Browser to Landing Page 
    Select Hotel
    Choose Dates and Guests 
    Select Room and Extras
    Fill in Payment Details     
    Simulate Success or Failure    success
    Close Dialog

Confirm Email
    [Documentation]     A new booker receives an email with a link to modify the booking 
    ${modify_link}=     Get Link from Email
    Open New Browser To URL    ${modify_link}
    Sleep      10s



