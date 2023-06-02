*** Settings ***

Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Library            Browser     auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality

*** Test Cases ***

Create A New Booking
    [Documentation]    A new booker opens the page and does a successful booking
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button
    Continue to Payment
    Verify Join for free is selected 
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank, Nordea as Payment Method
    Complete Payment
    Verify Payment was successful

Confirm Email and Open Link
    [Documentation]     A new booker receives an email with a link to modify the booking 
    ${modify_link}=     Get Link from Email
    Open New Browser To URL    ${modify_link}
    Sleep      10s



