*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

Create a new booking as a non-member
    [Tags]    smoke, booking, BUI2-556, online-checkin
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates     # In this case dates must be today for being able to check-in?
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

Complete Check in Process
    [Tags]    smoke, booking, BUI-556, online-checkin
    Click Check In Button
    Fill Check in Slide
    Click Save and Sign Button
    Sign
    Complete Check in

Verify UI when users have signed
    [Tags]    smoke, booking, BUI-556, skip, online-checkin
    Pass Execution  TBD
    Given the primary banner is configurable
    And the notification of the room number and door code is active
    And the guest list is visible
    And the booking summary is displayed
    And the "My bookings" link is visible
    And the secondary banner is configurable
    Then the sticky Call To Action (CTA) should be visible

Verify UI when users have not signed
    Pass Execution  TBD
    Configurable primary banner
    Check Notification of the room number and door code    ${False}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA

Verify UI when users have signed
    Pass Execution  TBD
    Configurable primary banner
    Check Notification of the room number and door code    ${True}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA


