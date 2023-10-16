
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/EC.resource
Library            Browser         auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Force Tags        kensington_stay

*** Test Cases ***

Start Creating a new Booking in MUI
    Open Browser to Nelson Portal and Navigate to Test Exhibition
    Open Reservations Page
    Click New Reservation Button
    Select Normal Reservation
    ${previous} =    Switch Page      NEW
    Wait Until Network Is Idle
    ${uuid}=     Create a successful booking and return UUID    True
