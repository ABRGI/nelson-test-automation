*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

Verify Page title when marks someone else as a guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Edit guest popup change to "Booker information"

Verify notification when marks someone else as a guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Verify notification "Before iniviting someone else to be the main guest in this room, you must fill in your own information"

Verify room name in Edit guest popup when marks someone else as a guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Room name is remove

Verify Purpose of trip checkbox in Edit guest popup when marks someone else as a guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    The "Purpose of the trip" checkbox is removed

Verify Save and invite button when marks someone else as a guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    The "Save and sign" button changes to " Save and invite" button


Verify Invite guest popup UI
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Verify the Invite Guest UI

Verify email field validation when invite guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Verify email with valid email

Verify invalid email field validation when invite guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Verify email with invalid email

Verify Warning popup when invite block guest
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Fill invite guest info with block guest email
    Verify Warning Popup is displayed with blocker email
    Close Warning popup

Verify invite guest with guest email same as booker email
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Fill invite guest infor with booker email
    Verify Warning Popup is displayed with booker email
    Close Warning popup
    Click Cancel button
    Booker is brought back to Comfirmation Landing page

Verify invite guest with valid information 
    Booker just completed payment for a reservation
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Invite guest popup is open
    Fill Invite guest info and click invite button
    Booker is brought back to Comfirmation Landing page
    Notice "Invite sent" displays
    Status of guest confirmation is changed to "Invite sent, not check-in"
    Verify Guest information component
    Verify Booking summary
    Verify Configurable secondary banner
    Verify Guest information popup when guest not checkin
    Click Uninvite button
    Verify Uninvite warning popup
    Click Univite button in Uninvite warning popup
   
    

