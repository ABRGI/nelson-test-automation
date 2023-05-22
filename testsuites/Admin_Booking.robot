*** Settings ***
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ../resources/keywords/booking.resource
Resource          ../resources/keywords/common.resource
Resource          ../resources/keywords/mui.resource

*** Test Cases ***
Admin Create A Booking
    Open Nelson Portal    ${MUI-Link}
    Log in MUI
    Open A MUI Client    Test (2) Omena
    New Reservation MUI
    Create New Reservation MUI
    Switch Page    NEW
    mui.Select Hotel    Turku, Humalistonkatu
    Find Room
    Select Room and Extras
    Fill in Payment Details    mui
    Verify Booking is Successful
    Click Booker or Guest Name    '${firstName}' '${lastName}'
    Verify Save and Sign State    ${False}
    Close Edit Booker or Guest
    [Teardown]    Run Keyword And Ignore Error    Log out of Nelson In BUI Confirmation Page