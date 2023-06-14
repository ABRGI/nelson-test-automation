*** Settings ***
Test Setup       Open Browser to Landing Page
Test Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

UI authentication Formerly guest info when invited adult
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 1 Room 2 Adult and 1 Children
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Booker is main guest and completes check-in process
    Click the first guest invite
    Verify Invite guest popup UI when guest is adult
    Fill in guest information when guest is adult 
    Verify Invite guest UI after invite

Univite pop-up UI validation
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 1 Room 2 Adult and 1 Children
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Booker is main guest and completes check-in process
    Click the first guest invite
    Verify Invite guest popup UI when guest is adult
    Fill in guest information when guest is adult
    Uninvite guest
    Verify Uninvite warning popup
    
UI authentication Formerly guest info when invited child
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 1 Room 2 Adult and 1 Children
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Booker is main guest and completes check-in process
    Click the secondary guest invite
    Verify Add guest popup UI when guest is children 
    Fill in guest information when guest is children
    Verify Add guest UI after save children information

UI validation when remove guest
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 1 Room 2 Adult and 1 Children
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Booker is main guest and completes check-in process
    Click the secondary guest invite
    Fill in guest information when guest is children
    Remove guest
    Verify Remove guest warning popup

UI validation when uninvite guest
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select 1 Room 2 Adult and 1 Children
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Booker is main guest and completes check-in process
    Click the first guest invite
    Verify Invite guest popup UI when guest is adult
    Fill in guest information when guest is adult
    Uninvite guest
    Verify Uninvite warning popup
    Click Univite button in Uninvite warning popup
    The user is uninvited from the reservation