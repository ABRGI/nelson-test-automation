*** Settings ***

Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A test suite for verifying modify booking functionality
Force Tags         smoke

*** Test Cases ***

Create A New Booking as
    [Documentation]    A new booker opens the page and does a successful booking
    Select Hotel     
    Select Dates
    Select Guests
    Click Book or Find Rooms Button
    Select a Standard Room
    Click Continue to Extras Button
    Continue to Payment
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully

Confirm Email and Open Link
    [Documentation]     A new booker receives an email with a link to modify the booking 
    ${i}=     Get Variable Value    ${new_inbox_id}    # Variable ID is set in booking.Fill in Contact Information
    Log To Console    Inbox ID: ${i}     # Variable ID is set in booking.Fill in Contact Information
    ${modify_link}=     Wait For Latest Booking Confirmation and Extract Link     ${i}
    Open New Browser To URL    ${modify_link}

