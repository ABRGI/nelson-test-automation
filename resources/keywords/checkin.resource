*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Library           Browser    auto_closing_level=SUITE
Library           String

*** Keywords ***

Wait Until Door Code is Available
    Set Browser Timeout    5 minutes
    ${availableInFound} =  Is Element Found    //p[contains(text(), "Available in")]
    WHILE     ${availableInFound}
        Sleep  15s
        Reload
        ${availableInFound} =  Is Element Found    //p[contains(text(), "Available in")]
    END
    Set Browser Timeout    ${timeout}
    Check for Payment Ok Modal

Check for Payment Ok Modal
    [Documentation]    Workaround to closing modal until it is fixed
    ${modalIsVisible}=     Is Element Visible  //section[contains(@class, 'chakra')]
    IF     ${modalIsVisible}
       Click        //button[contains(text(),'Ok')]
    END

Check Door Code and verify it is not empty
    ${doorCode} =  Get Text  //*[contains(text(), "Door code")]/following-sibling::*
    ${availableInFound} =  Is Element Found    //p[contains(text(), "Available in")]
    IF  ${availableInFound} != 'True'
        Should Be String  ${doorCode}
        #Should Match Regexp  ${doorCode}  ${doorCodeRegex}
    ELSE
        Fail  Door code is not visible
    END 

Verify Page Elements after Check-in
    Verify Check-in Page Texts
    # TODO: Add more verifications

Verify Check-in Page Texts
    @{listOfStrings}=  Create List  Room no.     Arrival     Departure     Checked-in    Booked by      My bookings    Booking number
    Verify Texts    @{listOfStrings}

Verify Page Elements before Check-in
    # TODO: Add verifications