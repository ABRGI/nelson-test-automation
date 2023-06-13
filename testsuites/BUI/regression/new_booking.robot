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
    Select Join for Free
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully

Confirm Email and Open Link
    [Documentation]     A new booker receives an email with a link to modify the booking 
    ${id} =    Get Variable Value    $ID
    ${modify_link}=     Wait For Latest Booking Confirmation    ${id}
    Open New Browser To URL    ${modify_link}

