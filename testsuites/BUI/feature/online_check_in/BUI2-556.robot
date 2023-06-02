*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource


*** Keywords ***

Verify Booking Details 
    Pass Execution      TBD

Verify Check in Button is Visible and Click
    Wait Until Visible    (//button[text()="Check in"])[1]
    Click                 (//button[text()="Check in"])[1]

Verify Check in Slide is Visible and Fill
    Wait Until Visible    (//div[contains(@class, "chakra-offset-slide")])[2]
    Fill Text             id=firstName     ${firstName}
    Fill Text             id=lastName     ${lastName}
    Fill Text             id=ssn         ${ssn}
    # TBD: Should be dynamic test data not hardcoded
    Fill Text             id=address         Susitie 5
    Fill Text                id=city         Paimio  
    Fill Text                id=postalCode     21530
    Click             //span[contains(text(), "Travelling for work")]

Click Save and Sign Button
    Click                 //button[contains(text(), "Save and Sign")]



Verify Canvas is Visible and Sign
    Wait Until Visible    //canvas
    ${canvas}=        Get Element    xpath=//canvas
    Click Element    ${canvas}     position_x=900    position_y=900

Verify Check in is Completed 
    Wait Until Visible    //div[contains(text(), "Check in completed")]

*** Test Cases ***

Create a new booking as a non-member
    [Tags]    smoke, booking, BUI-556, online-checkin
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates     # In this case dates must be today for being able to check-in?
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

Complete Check in Process
    [Tags]    smoke, booking, BUI-556, skip, online-checkin
    Verify Check in Button is Visible and Click
    Verify Check in Slide is Visible and Fill
    Click Save and Sign Button
    Verify Canvas is Visible and Sign
    Verify Check in is Completed

Verify UI when users have signed
    [Tags]    smoke, booking, BUI-556, skip, online-checkin
    Given the primary banner is configurable
    And the notification of the room number and door code is active
    And the guest list is visible
    And the booking summary is displayed
    And the "My bookings" link is visible
    And the secondary banner is configurable
    Then the sticky Call To Action (CTA) should be visible

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


