*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Documentation     This is a test suite for booking a room and checking in online
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ${EXECDIR}/resources/keywords/checkin.resource
Test Tags        smoke, booking, BUI2-556, online-checkin    regression

*** Test Cases ***


Select Hotel, Dates and Guests
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates
    Select Guests

Check Available Rooms and Select a Standard Room
    Click Book or Find Rooms Button
    Select a Standard Room

Continue to Extras and Select Join for Free
    Click Continue to Extras Button
    Continue to Payment
    Select Join for Free

Fill in Booker Contact Information
    Fill in Contact Information 
    Accept offers and Terms

Pay using Web Bank and Nordea
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully

Check In Online
    Click Check In Button
    Fill Check in Slide
    Click Save and Sign Button and Sign if Required
    Complete Check in

Wait for Door Code and Verify Page
    Wait Until Door Code is Available
    Check Door Code and verify it is not empty
    Verify page elements after Check-in