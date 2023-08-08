
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/EC.resource
Library            Browser         auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality
Force Tags        exhibition_court


*** Keywords ***

Open Booking.com
    [Arguments]    ${BDCUrl}    ${BDCHotelId}
    Open New Browser To URL     ${BDCUrl}${BDCHotelId}&test=1
    Log To Console        ${BDCUrl}${BDCHotelId}&test=1

Check Availability for Today
    ${day}    ${month}    Get Selectors for For Date
    Select Options By    id=check-availability__checkin-monthday    value     ${day} 
    Select Options By    id=check-availability__checkin-yearmonth   value     2023-${month}        #TBD: Add year to be dynamic
    Click                 //span[contains(text(), 'Check availability')]
   # Wait Until Network Is Idle

Fill Contact Information in BDC
    ${id}=     Get Inbox ID
    Click and Fill     id=firstname    ${firstName}
    Click and Fill     id=lastname    ${lastName}
    Click and Fill    id=email       ${id}@mailslurp.com
    Log To Console    ${id}
    Set Suite Variable      $ID     ${id}
    Click and Fill            id=remarks        testRemark
    #Click          //input[contains(@value,'business')]
    Click          //input[contains(@class, 'guest-name-input')]
    Click         id=firstname
    Click         id=lastname
    Click         id=email
    ${isVisible}=     Is Element Visible    //div[contains(@class, 'bui-modal--active')]
    IF     '${isVisible}' == 'True'
        Click         //button[contains(@class, 'bui-modal__close')]
    END
    Click         id=bp-control-group__label--notstayer
    Click          //span[contains(text(), 'Final details')]
    Wait Until Visible        //select[@data-phone-country]
    Select Options By         //select[@data-phone-country]    value     FI         
    Fill Text      id=phone     ${phone}

Click BDC Book Button
    Click        //button[@name='book']
    Set Browser Timeout    ${longer}
    Wait Until Visible    //button[contains(@class, 'bui-modal__close')]

*** Test Cases *** 

Open BDC and Check for Availability
    Open Booking.com    ${BDCUrl}    ${BDCHotelId}
    Check Availability for Today

Create Reservation
    ${reserveButton}=     Is Element Visible    //button[@name='book']
    Select Options By    //select[contains(@id, 'unit')]    value     1
    Click                 //span[contains(text(), 'reserve')]

Fill Contact Information and Payment Details
    ${id}=         Get Inbox ID
    Fill Contact Information in BDC
    Fill in Card Details
    Click BDC Book Button

Verify Emails and Get Booking No
    ${id}=     Get Inbox ID
    ${confirmationEmail}=         Wait for Latest Booking Confirmation            ${id}    is confirmed
    ${welcomeEmail}=     Wait for Latest Booking Confirmation       ${id}        Booking confirmation
    ${bookingNo}=         Get Confirmation Number from Email     ${welcomeEmail}
    Set Suite Variable     ${BDCNo}        ${bookingNo}

Create A New Booking on Booking.com for a later date and verify Emails
    Pass Execution     TBD

Cancel Booking via BDC
    Pass Execution     Can't cancel if done upon the next 24 hours

Open Booking in MUI
    Open Browser to Nelson Portal and Navigate to Test Exhibition
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

Start Creating a new Booking in MUI
    Open Browser to Nelson Portal and Navigate to Test Exhibition
    Open Reservations Page
    Click New Reservation Button
    Select Normal Reservation
    ${previous} =    Switch Page      NEW
    Wait Until Network Is Idle
    ${uuid}=     Create a successful booking and return UUID    True
