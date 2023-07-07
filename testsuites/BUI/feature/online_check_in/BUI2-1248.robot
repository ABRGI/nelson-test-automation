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
   Verify required field presence   Social security number   ${True}
   Verify required field presence   Passport number   ${False}  
   #Verify when changing to other nationalities
   Search & select nationality   Vietnam
   Verify required field presence   Social security number   ${False}
   Verify required field presence   Passport number   ${True} 
   #Verify when changing nationality back to Finland
   Search & select nationality   Finland
   Verify required field presence   Social security number   ${True}
   Verify required field presence   Passport number   ${False} 

Verify booker invites guest with already used email address
   Booker just completed payment for a reservation with 1 room 3 guest
   Booker is brought back to Comfirmation Landing page
   Booker is main guest and completes check-in process
   Click the first guest invite
   Verify Invite guest popup UI when guest is adult
   Fill Invite guest info and click invite button   Auto   Test   finlong1111@gmail.com
   Verify Warning Popup is displayed with booker email