*** Settings ***

Suite Teardown    Close Browser    ALL
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/customer_specific/kensington_stay/kensington_stay.resource
Library           Browser         auto_closing_level=SUITE
Documentation     A test suite for verifying the Kensington Stay Home Page
Force Tags        kensington_stay
Suite Setup       Set Browser Timeout    8s

*** Test Cases ***

Open Kensington Stay Home Page
    Open New Browser To KS Home Page
    ${title}=     Get Title
    Should Be Equal    ${title}    Kensington Stay
    Verify Texts    Check In    Book    What to do    How it Works    

Open Menu and Click Book a Room
    Click     //div[contains(@class,"nav-menu-button-container")]
    Click     //a[contains(text(),"Book a Room")]
    ${url.current}=    Get Url
    Should Contain       ${url.current}     /booking

Verify Booking Page Elements 
    Verify Texts     Find rooms     Your booking overview     Kensington Stay

Create New Booking in KS
    Click   //div[contains(@class, "display-desktop-up")]//a[contains(@class, "white")]
    Complete a new booking    True
    Fill in TyL Details
    Wait Until Network Is Idle
    Check for Payment Ok Modal

Start Check in Process
    Verify Texts        Please update    Booking number    Kensington Stay Hotel    My bookings
    Click Check In Button
    Click Upload ID Button
    Click 

# Add this to booking/checkin


# When canceling booking on payment, it will return to find my booking
