
*** Settings ***

Suite Teardown    Close Browser    ALL
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Library            Browser     auto_closing_level=SUITE
Documentation      A test suite for verifying modify booking functionality

*** Variables ***

${BDCNo}     547370586    #Default for debug, is overridden in full test suite run

*** Test Cases ***

Create A New Booking on Booking.com for today and verify Emails
    ${id}=     Get Inbox ID
    Open New Browser To URL     https://secure.booking.com/book.html?hotel_id=10304890&test=1
    ${day}    ${month}    Get Selectors For Tomorrow
    Select Options By    id=check-availability__checkin-monthday    value     ${day} 
    Select Options By    id=check-availability__checkin-yearmonth   value     2023-${month}        #TBD: Add year to be dynamic
    Click                 //span[contains(text(), 'Check availability')]
    Wait Until Network Is Idle
    ${urlContains}=     Check URL Contains    searchresults
    IF    '${urlContains}' == 'True'
        Fail   Rooms not is not available for this date
    ELSE 
        Select Options By    //select[contains(@id, 'unit')]    value     1
        Click                 //span[contains(text(), 'reserve')]
        ${id}=         Get Inbox ID
        Click and Fill     id=firstname    ${firstName}
        Click and Fill     id=lastname    ${lastName}
        Click and Fill    id=email       ${id}@mailslurp.com
        Log To Console    ${id}
        Set Suite Variable      $ID     ${id}
        Click and Fill            id=remarks        testRemark
        #Click          //input[contains(@value,'business')]
        Click          //input[contains(@class, 'guest-name-input')]
        Click          //span[contains(text(), 'Final details')]
        Wait Until Visible        //select[@data-phone-country]
        Select Options By         //select[@data-phone-country]    value     FI         
        Fill Text      id=phone     ${phone}
        Click        //button[@name='book']
        Set Browser Timeout    ${longer}
        Wait Until Visible    //button[contains(@class, 'bui-modal__close')]
    END

Verify Emails and Get Booking No
    ${id}=     Get Inbox ID
    ${confirmationEmail}=         Wait for Latest Booking Confirmation            ${id}    is confirmed
    ${welcomeEmail}=     Wait for Latest Booking Confirmation       ${id}        Welcome to Exhibition Court Hotel
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

Start Creating a new Booking in MUI
    Open Browser to Nelson Portal and Navigate to Test Exhibition
    Open Reservations Page
    Click New Reservation Button
    Select Normal Reservation
    ${previous} =    Switch Page      NEW
    Wait Until Network Is Idle
    ${uuid}=     Create a successful booking and return UUID    True
