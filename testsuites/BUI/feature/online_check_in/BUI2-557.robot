*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

Verify UI When in booker view
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate
    Select Join for Free
    Check Regular Rate
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Click Check In Button
    Click Someone else checkbox
    Fill In Booker info
    Click Save and invite
    Fill Invite guets info and click invite button
    Open Edit booker info
    Verify All information is disbled
    Check Add organization check box
    Fill organization info
    Verify all information are Save

Validation shows msg for fields marked with "*"
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate
    Select Join for Free
    Check Regular Rate
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Click Check In Button
    Click Someone else checkbox
    Click Save and invite
    Verify msg The field is required
    Fill invalid phone format
    Verify msg "Invalid phone number!"
    Fill invalid SSN
    Verify msg "Please check! This is not a Finnish social security number"

Showing imported passport when the National is not Finland
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate
    Select Join for Free
    Check Regular Rate
    Fill contact info with the National not Finland
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully
    Click Check In Button
    Click Someone else checkbox




     

    
    
    
    
