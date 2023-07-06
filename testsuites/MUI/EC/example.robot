*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
#Suite Setup       Verify Variables
Suite Teardown    Close Browser 
Force Tags        exhibition_court    smoke
*** Test Cases ***


Open MUI
    Open Browser to Nelson Portal and Navigate to Test Exhibition
    
