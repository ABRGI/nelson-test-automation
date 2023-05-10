*** Settings ***
Library            ../resources/libraries/Helpers.py
Resource           ../resources/variables/variables.resource
Resource           ../resources/keywords/booking.resource
Library            Browser    auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Suite Setup        Open Browser to Landing Page 
Force Tags         skip 

*** Test Cases ***

The booker opens the edit guest page
    A new booker makes a reservation
    Successfully completes a payment
    Booker clicks on main guest name
    Edit guest page is opened
    Save and Sign button is visible

The booker changes the main guest to someone else
    Toggle Someone Else Checkbox
    Save and Sign button is visible 
    Fill in Other Guest Details 
    Click Save and Sign

#The booker changes the main guest to be the booker
 #   Pass Execution         Case not understood here really, what's the difference?
    #Given the booker navigtaes to the edit guest page
    #When the booker marks the "Someone else will be the main guest" checkbox as <false>
    #Then the text on the save button is displayed as "Save and Sign"