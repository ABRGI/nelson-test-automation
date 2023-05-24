*** Settings ***
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource
Test Teardown    Run Keyword And Ignore Error    Log out of Nelson In BUI Confirmation Page

*** Test Cases ***
Admin Create A Booking
    [Documentation]    Forcing signature in reservations created by Admin
    ...
    ...    Scenario: Admin create a booking (normal, contract, group)
    ...    Given Admin creates a booking
    ...    When it comes to confimration page
    ...    Then no web element (textbox, labels,..) related to forcing signature is shown
    ...
    ...
    ...
    ...    Scenario: Reservation done by normal users then edited by Admin
    ...    Given Normal user completed a reservation
    ...    And Normal user hasn't signed
    ...    And Admin edits the booking
    ...    And reservation is confirmed
    ...    When it comes to confirmation page
    ...    Then no web element (textbox, labels,..) related to forcing signature is shown
    [Tags]    MUI-424
    Go to MUI    ${MUI-Link}               # Variable should not be shown here
    Log in MUI Fail
    Log in MUI Successful
    Open A MUI Client    Test (2) Omena
    New Reservation MUI
    Create New Reservation MUI
    Go to New tab
    Select Hotel    
    Find Room
    Select Room and Extras
    Fill in Payment Details    mui
    Verify Booking is Successful
    Click Booker or Guest Name    '${firstName}' '${lastName}'
    Verify Save and Sign State    ${False}
    Close Edit Booker or Guest
  
   
