
*** Settings ***


Library            ${EXECDIR}/resources/libraries/Helpers.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A test suite for verifying modify booking functionality
Suite Teardown     Close Browser
Library            Browser    auto_closing_level=SUITE


*** Test Cases ***

Create A New Booking
    [Documentation]    A new booker opens the page and does a successful booking
    Open Browser to Landing Page 
    Select Hotel      
    Choose Dates and Guests 
    Select Room and Extras
    Fill in Payment Details 
    Fill
    Close Dialog 

Confirm Email and Open Link
    [Documentation]    The booker reads their email and opens the link
    Pass Execution    
    #Open Email
    #Get Link 
    #Open Link
