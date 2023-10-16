
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/EC.resource
Library            Browser         auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Force Tags        kensington_stay


*** Test Cases *** 


Create A New Booking on Booking.com for a later date and verify Emails
    Pass Execution     TBD

Open Booking in MUI
    #${environment}=     Set Variable     Test Kensington Stay
    Open Browser to Nelson Portal and Navigate to Kensington Stay
    Log     In Nelson, looking for booking: ${BDCNo}
    Search with String    ${BDCNo}
    Sleep     2s
    Click     //*[contains(text(), '${BDCNo}')]
    Wait Until Keyword Succeeds        2    5     Click View Guests Button

Cancel Booking in MUI
    Click     //button[contains(text(), 'Cancel')]
    Click     //button[contains(text(), 'Yes')]
    Wait Until Keyword Succeeds        2    5     Click View Guests Button
    ${status}=     Get Text     //span[contains(@class, 'status')]
    Should Be Equal As Strings     ${status}     Cancelled