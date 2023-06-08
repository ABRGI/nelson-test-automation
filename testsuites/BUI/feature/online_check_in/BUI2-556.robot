*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ${EXECDIR}/resources/keywords/checkin.resource

*** Test Cases ***

Create a new booking, check-in and verify door code is displayed
    [Tags]    smoke, booking, BUI2-556, online-checkin
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates
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
    Verify Page Elements before check-in
    Click Check In Button
    Fill Check in Slide
    Click Save and Sign Button
    Sign
    Complete Check in
    Wait Until Door Code is Available
    Check Door Code and verify it is not empty
    Verify page elements after Check-in