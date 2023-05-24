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
Scenario: UI appearance when signing is not done
    Given Booker just completed payment for a reservation
    And Booker is at page 3
    And Booker doesn’t check the “Someone else will be the main guest” checkbox
    When Signing is not done
    Then Follows are visible: Configurable primary banner, Guest list, Booking summary, My bookings link, configurable secondary banner, sticky CTA
    And Notification of the room number and door code is NOT shown

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
