*** Settings ***
Library            ${EXECDIR}/resources/libraries/Helpers.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A test suite for verifying modify booking functionality
Suite Setup        Open Browser to Landing Page 
Test Setup
Force Tags         skip 

*** Test Cases ***

A new booker opens the edit guest page and changes the main guest to someone else
    Pass Execution     TBD
    A new booker makes a reservation
    Successfully completes a payment
    Booker clicks on main guest name
    Edit guest page is opened
    Save and Sign button is visible
    Toggle Someone Else Checkbox
    Save and Sign button is visible 
    Fill in Other Guest Details 
    Click Save and Sign

#TBD: The booker changes the main guest to be the booker
    #Given the booker navigtaes to the edit guest page
    #When the booker marks the "Someone else will be the main guest" checkbox as <false>
    #Then the text on the save button is displayed as "Save and Sign"