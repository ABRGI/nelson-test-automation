*** Settings ***
Test Teardown     Run Keyword And Ignore Error    Log out of Nelson In BUI Confirmation Page
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ../resources/keywords/booking.resource
Resource          ../resources/keywords/common.resource
Resource          ../resources/keywords/mui.resource

*** Test Cases ***
Admin creates booking
    [Documentation]    Forcing signature in reservations created by Admin
    ...
    ...    Scenario: Admin create a booking (normal, contract, group)
    ...    Given Admin creates a booking
    ...    When it comes to confimration page
    ...    Then no web element (textbox, labels,..) related to forcing signature is shown
    ...
    ...    Scenario: Reservation done by normal users then edited by Admin
    ...    Given Normal user completed a reservation
    ...    And Normal user hasn't signed
    ...    And Admin edits the booking
    ...    And reservation is confirmed
    ...    When it comes to confirmation page
    ...    Then no web element (textbox, labels,..) related to forcing signature is shown
    [Tags]    MUI-424
    Open Nelson Portal    ${MUI-Link}
    Log in MUI
    Open A MUI Client    Test (2) Omena
    New Reservation MUI
    Create New Reservation MUI
    Go to New Tab
    Select A Hotel    Turku, Humalistonkatu    ${True}
    Find Room
    Select Room and Extras
    Fill in Payment Details    env=mui
    Verify Booking is Successful    ${False}
    Click Booker or Guest Name    '${firstName}' '${lastName}'
    Verify Save and Sign State    ${True}
    Close Edit Booker or Guest
