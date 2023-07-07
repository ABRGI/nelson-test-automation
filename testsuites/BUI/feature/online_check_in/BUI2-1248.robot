*** Settings ***
Test Setup       Open Browser to Landing Page
Test Teardown    Close Browser
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Test Cases ***

Verify UI when Booker has not update Information
   Booker just completed payment for a reservation with 1 room 3 guest
   Booker is brought back to Comfirmation Landing page
   Booker does not update information
   Verify UI confirmation landing page when Booker does not update information 

Verify User changes to another nationality than Finland and vice versa
   Booker just completed payment for a reservation with 1 room 3 guest
   Booker is brought back to Comfirmation Landing page
   Click Check In Button
   #Verify SSN field with Placeholder is displayed by default
   Verify Element Presence    //div[normalize-space()='Social security number*']//input[@id='ssn' and @required]    ${True}
   Verify Element Presence   //div[normalize-space()='Passport number*']//input[@id="passportNumber" and @required]   ${False}
   #Verify when changing to other nationalities
   Search & select nationality   Vietnam
   Verify Element Presence    //div[normalize-space()='Social security number*']//input[@id='ssn' and @required]    ${False}
   Verify Element Presence   //div[normalize-space()='Passport number*']//input[@id="passportNumber" and @required]   ${True}
   #Verify when changing nationality back to Finland
   Search & select nationality   Finland
   Verify Element Presence    //div[normalize-space()='Social security number*']//input[@id='ssn' and @required]    ${True}
   Verify Element Presence   //div[normalize-space()='Passport number*']//input[@id="passportNumber" and @required]   ${False}