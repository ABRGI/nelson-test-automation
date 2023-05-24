*** Settings ***
Suite Setup       Open Browser to Landing Page
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***
Make a booking
    mui.Select Hotel    Turku, Humalistonkatu
    Comment    Find Room
    Choose Dates and Guests
    Select Room and Extras
    Comment    Continue to Payment
    Check Regular Rate
    Check Join as Member
    Check Regular Rate
    Fill Contact Info
    Accept Term and Proceed to Payment
    Quickly Pay
    ${code}    Verify Successful Booking

Verify UI when users have not signed

Verify UI when users have signed
