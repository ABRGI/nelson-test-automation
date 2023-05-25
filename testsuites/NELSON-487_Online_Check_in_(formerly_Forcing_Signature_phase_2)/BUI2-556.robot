*** Settings ***
Documentation     Scenario: UI appearance when signing is not done
...                Given Booker just completed payment for a reservation
...               And Booker clicks edit guest info
...               And Booker does not check the Someone else will be the main guest checkbox
...               When Signing is not done
...               Then Follows are visible: Configurable primary banner, Guest list, Booking summary, My bookings link, configurable secondary banner, sticky CTA
...               And Notification of the room number and door code is NOT shown
...
...               Scenario: UI appearance when signing is done
...               Given Booker just completed payment for a reservation
...               And Booker is at page 3
...               And Booker doesn’t check the “Someone else will be the main guest” checkbox
...               When Signing is done for whole reservation
...               Then Follows are visible: Configurable primary banner, Guest list, Booking summary, My bookings link, configurable secondary banner, sticky CTA
...               And Notification of the room number and door code is shown
Test Setup        Open Browser to Landing Page
Test Teardown     Close Browser
Force Tags        skip    BUI2-556
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***
Scenario: UI appearance when signing is not done
    Given Booker just completed payment for a reservation
    And Booker Clicks On Name At Page 3
    And Booker does not check the Someone else will be the main guest checkbox
    When Signing is not done
    Then Follows are visible: Configurable primary banner, Guest list, Booking summary, My bookings link, configurable secondary banner, sticky CTA
    And Notification of the room number and door code is NOT shown

Scenario: UI appearance when signing is done
    Given Booker just completed payment for a reservation
    And Booker Clicks On Name At Page 3
    And Booker does not check the Someone else will be the main guest checkbox
    When Signing is done for whole reservation
    Then Follows are visible: Configurable primary banner, Guest list, Booking summary, My bookings link, configurable secondary banner, sticky CTA
    And Notification of the room number and door code is shown
