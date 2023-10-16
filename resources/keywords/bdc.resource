*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource

*** Keywords ***


Open Booking.com to KS Test
    Open New Browser To URL     ${BDCUrl}${BDCHotelId}&test=1
    Log To Console        ${BDCUrl}${BDCHotelId}&test=1

Check Availability for Today
    ${day}    ${month}    Get Selectors for For Date
    Select Options By    id=check-availability__checkin-monthday    value     ${day} 
    Select Options By    id=check-availability__checkin-yearmonth   value     2023-${month}        #TBD: Add year to be dynamic
    Click                 //span[contains(text(), 'Check availability')]

Verify Book Button is Visible
    ${reserveButton}=     Is Element Visible    //button[@name='book']

Select Room Type
    Select Options By    (//select[contains(@id, 'unit')])[1]    value     1

Click I'll Reserve
    Click                 //span[contains(text(), 'reserve')]

Fill Contact Information in BDC
    ${id}=     Get Inbox ID
    Click and Fill with Sleep     id=firstname    ${firstName}
    Click and Fill with Sleep     id=lastname    ${lastName}
    Click and Fill with Sleep     id=email       ${id}@mailslurp.com
    Click     xpath=//div[contains(@class, 'bp-personal-details-form')]
    ${emailErrorVisible}=     Is Element Visible         //p[contains(text(),'be wrong')]
    IF     '${emailErrorVisible}' == 'True'
        Click     id=email
        Click     xpath=//div[contains(@class, 'bp-personal-details-form')] 
    END 
    ${phoneNoVisible}=     Is Element Visible    //select[@data-phone-country]
    IF    '${phoneNoVisible}' == 'True'
            Select Options By         //select[@data-phone-country]    value     FI  
    Wait Until Visible        //select[@data-phone-country]
    END
    Log To Console    ${id}
    Set Suite Variable      $ID     ${id}
    Click and Fill with Sleep            id=remarks        testRemark

    Click   //span[contains(text(), 'Final details')]
    ${isVisible}=     Is Element Visible    //div[contains(@class, 'bui-modal--active')]
    IF     '${isVisible}' == 'True'
        Click         //button[contains(@class, 'bui-modal__close')]
    END
    ${phoneNoVisible}=     Is Element Visible    //select[@data-phone-country]
    IF    '${phoneNoVisible}' == 'True'
            Select Options By         //select[@data-phone-country]    value     FI  
    Wait Until Visible        //select[@data-phone-country]
    END

    Select Options By         id=cc1       value         us     
    Sleep     1s    
    Click and Fill with Sleep      id=phone     ${phone.no.zero}
    Click         //div[contains(@class, 'bp-personal-details-form')]
    Click          //span[contains(text(), 'Final details')]

Click BDC Book Button
    Click        //button[@name='book']
    Set Browser Timeout    ${longer}
    Wait Until Visible    //button[contains(@class, 'bui-modal__close')]

Fill in Card Details
    [Documentation]      Fill in Card Details in BDC
    Click and Fill with Sleep      id=cc_name    Card Holder 
    Select Options By    id=cc_type    value     Visa
    Click     id=cc_type
    Click and Fill with Sleep       id=cc_number    4153013999700321
    Select Options By    id=cc_month    value     11
    Select Options By    id=ccYear    value     2023   
    Click and Fill with Sleep       id=cc_cvc    321

Verify Emails and Set Booking No
    [Documentation]    Waits for latest booking confirmation by subject, extracts links to CSV file and gets booking number
    ${id}=     Get Inbox ID
    ${confirmationEmail}=     Wait for Latest Booking Confirmation       ${id}        Booking confirmation
    ${all_links}=         Extract All Links to CSV     ${confirmationEmail}
    ${bookingNo}=         Get Confirmation Number from Email     ${confirmationEmail}
    Log To Console         ${bookingNo}
    Append To Environment Variable    LAST_BOOKING_NO:${bookingNo}

Click Reserve Button to Start
    ${reserveButton}=     Is Element Visible    //button[@name='book']

Select Number of Rooms and Reserve
    Select Options By    //select[contains(@id, 'unit')]    value     1
    Click                 //span[contains(text(), 'reserve')]