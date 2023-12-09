*** Settings ***
Documentation     This is a test suite for booking a room and checking in online
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Resource          ${EXECDIR}/resources/keywords/checkin.resource
Force Tags        skip

*** Variables ***

${url.expedia.direct}    https://www.expedia.com/Region-Test-Hotels-EQC-Hotel-502.h17113366.Hotel-Information

*** Keywords ***

Open Browser to Expedia Omena Test Hotel
    Open New Browser To URL    ${url.expedia.direct}

Select Dates for Expedia Stay
    
    ${tomorrow}=        Get Tomorrows Day Number
    ${day_after}=       Get Day After Tomorrow
    Click     //button[contains(@name, "EGDSDateRange-date-selector-trigger")]
    #Click     (//button[contains(@data-day,"${tomorrow}")])[1]
    #Click     (//button[contains(@data-day,"${day_after}")])[1]
    #Click    //button[contains(@data-stid, "apply-date-picker")]

*** Test Cases ***

Check Availability in Expedia
    #Pass Execution    TBD
    Open Browser to Expedia Omena Test Hotel
    Select Dates for Expedia Stay
    Click     id=search_button

Select Hotel and Create Booking
     Pass Execution    TBD
    Click     //a[contains(@href, "Region-Test-Hotels-EQC")]

    # TODO THIS IS HIDDEN; SHOULD SELECT PARENT BUTTON
    Click     //span[contains(text(), 'Select Standard')]

Fill Booker Details
    Pass Execution    TBD
    ${noCC}=     Is Element Visible     //button/span[contains(@aria-hidden, "false") and text()="Pay when you stay"]
    IF     '${noCC}' == 'True'
        Click     //button/span[contains(@aria-hidden, "false") and text()="Pay when you stay"]

    ELSE
        Click     //button/span[contains(@aria-hidden, "false") and text()="Pay when you stay"]
        Fill Text     //input[contains(@class, "billing-cardholder-name")]        Expedia Ex
        Fill Text     id=creditCardInput    ${cc.expedia}
        Fill Text      //input[contains(@class, "cc-expiration-text-field")]     ${cc.expedia.exp}
        Fill Text      //input[contains(@class, "new_cc_security_code")]     123
    END
    Fill Text    //input[contains(@name, "firstName")]        Expedia
    Fill Text      //input[contains(@name, "lastName")]        Expedia
    Fill Text    //input[@name='email' and contains(@class, 'always-include')]    nelsonsqa+expedia@gmail.com
    Fill Text    //input[contains(@class, "phone-number")]        111

      