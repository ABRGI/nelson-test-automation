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
