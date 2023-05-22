*** Settings ***
Suite Setup       Open Browser to Landing Page
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ../../resources/keywords/booking.resource
Resource          ../../resources/keywords/common.resource
Resource          ../../resources/keywords/mui.resource
Force Tags        skip

*** Test Cases ***
Make a booking
    Select Hotel    Turku, Humalistonkatu
    Find Room
    Choose Dates and Guests
    Select Room and Extras
    Continue to Payment
    Check Regular Rate
    Check Join as Member
    Check Regular Rate
    Fill Contact Info
    Accept Term and Proceed to Payment
    Quickly Pay
    ${code}    Verify Successful Booking

Verify UI when users have not signed
    Configurable primary banner
    Check Notification of the room number and door code    ${False}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA

Verify UI when users have signed
    Configurable primary banner
    Check Notification of the room number and door code    ${True}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA
