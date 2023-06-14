*** Settings ***
Test Setup       Open Browser to Landing Page
Test Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

Verify UI when Booker has not updated information
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 2 Rooms 5 Adults
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Verify Comfirmation Landing page when Booker has not updated information

Verify UI when Booker has fully updated information
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 2 Rooms 5 Adults
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Click Check In Button   
    Booker is main guest and completes check-in process
    