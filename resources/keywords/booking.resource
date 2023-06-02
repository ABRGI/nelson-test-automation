*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Library           Browser    auto_closing_level=SUITE
Library           String

*** Keywords ***

Click First Element Found
    [Arguments]    ${xpath}
    ${elements}    Get Elements          ${xpath}
    ${first_element}=    Set Variable    ${elements}[0]
    Click    ${first_element}

A new booker makes a reservation
    [Documentation]    A new booker makes a reservation
    Select Hotel
    Choose Dates and Guests
    Select Room and Extras

Successfully completes a payment
    [Documentation]    The payment is successfully completed
    Fill in Payment Details
    Simulate Success or Failure    success

Booker clicks on booker information
    [Documentation]    Booker clicks on booker information
    Click    (//p[contains(text(), "Details needed for receiving")])[1]
    # Wait Until Visible

Booker clicks on main guest name
    [Documentation]    Booker clicks on main guest name
    Click    (//p[contains(text(), "Details needed for receiving")])[2]
    # Wait Until Visible

Edit guest page is opened
    [Documentation]    Verifeies guest page is opened
    Wait Until Visible    id=chakra-modal-114

Save and Sign button is visible
    [Documentation]    Verifies the save and sign button is visible
    Wait Until Visible    //button[@data-ga4-event="add_guest_information"]

Toggle Someone Else Checkbox
    [Documentation]    Toggles the "Someone else will be the main guest" checkbox
    Click    //span[contains(text(),"Someone else")]

Click Book Button 
    Click            //div[@data-nelson-btn='book']
    
Click Cancel
    [Documentation]    Clicks the cancel button
    Click    //footer/button[text()="Cancel"]

Verify Email 
    ${modify_link}=     Get Link from Email

Open Link from Email 
    [Arguments]         ${link}
    Open New Browser To URL    ${link}

Verify edit booking page
    [Documentation]    Verifies the edit booking page is opened with correct values 
    Pass Execution     TBD: Should be implemented

Verify Email and Open Link
    ${link}=        Verify Email 
    Open Link from Email    ${link}
    Verify edit booking page

Signature modal is visible
    [Documentation]    Verifies the signature modal is visible
    Wait Until Visible    id=chakra-modal--body-115

Fill in Other Guest Details
    [Arguments]    ${firstName}=Snoop    ${lastName}=Dogg    ${email}=nelsontestar@gmail.com    ${phone}=040123942    ${ssn}=170479-371J
    [Documentation]    Fills in other guest details, which can be given as arguments or uses default values
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email    ${email}
    Click and Fill    id=phone    ${phone}
    # ${ssn}=    Generate SSN
    Click and Fill    id=ssn    ${ssn}

Click Save and Sign
    [Documentation]    Clicks the save and sign button
    Click    //button[@data-ga4-event="add_guest_information"]

Text on the save button is displayed as "${expected_text}"
    [Documentation]    Verifies the text on the save button is displayed as expected
    ${save_button_text}=    Get Text    xpath=//button[contains(text(),'Save and Sign')]
    Should Be Equal As Strings    ${save_button_text}    ${expected_text}

Booker navigates to edit guest page
    [Documentation]    TBD: Should be implemented
    Pass Execution    Implementation code to complete a payment

Marks the "Someone else will be the main guest" checkbox as <value>
    [Documentation]    TBD: Should be impemented
    Pass Execution    Implementation code to complete a payment

Select Guests
    [Arguments]    ${rooms}=1    ${persons}=1    ${children}=0
    [Documentation]    Selects the number of guests for the booking, current implementation will only check the dropdown
    Wait Until Visible    //div[contains(@data-nelson-btn, 'guests')]
    Click    //div[contains(@data-nelson-btn, 'guests')]
    #Click    //div[contains(@data-nelson-btn, 'guests')]
    # Click    (//button[contains(@data-nelson-guests-add, 'rooms')])[1]

Choose Dates and Guests
    # TODO: Add date selection when kw ready
    Select Guests
    

Select Hotel
    [Arguments]    ${hotel}=Lönnrotin
    [Documentation]    Select Hotel by using a number as an argument, default Lönnrotinkatu
    Log    Selecting Hotel: ${hotel}
    Click    //div[contains(@data-nelson-btn, "hotels")]
    Wait Until Visible    //a[contains(@class, 'dropdown-item') and contains(text(), '${hotel}')]
    Click    //a[contains(@class, 'dropdown-item') and contains(text(), '${hotel}')]
    Wait Until Network Is Idle

Select Dates
    [Documentation]    A keyword for selecting dates for booking
    # TODO: Currently this selects the first available date, should be changed to select a date in the future
    # Could be improved
    Click    //div[contains(@class, 'booking-form-dates')]
    ${container}=    Get Element    //div[@class="container__months"]
    ${html}=    Get Property    ${container}    innerHTML
    Log    ${html}
    @{elements}=    Get Elements    //div[@class="day-item"]
    ${selected}=    Set Variable    1
    FOR    ${e}    IN    @{elements}
        ${visibility}=    Get Element States    ${e}    then    value & (visible | hidden)
        IF    ${visibility} == 'visible'
        Click    ${e}
        ${selected}=    Set Variable    ${selected} + 1
    END
    ${both}=    Evaluate    ${selected} > 2
    Exit For Loop If    ${both}
    END

Click Continue to Payment 
    Click First Element Found    //div[contains(@class, 'chakra-stack')]//button[contains(text(), 'Continue')))]
    Wait Until Visible   ${btnPayment}

Click Continue to Extras Button and Continue to Payment
    [Documentation]    Clicks the continue to extras button and continues directly to Payment
    Click    ${btnExtras}
    Wait For Elements State    ${btnPayment}    visible    timeout=${timeout}
    Click Continue to Payment

Click Continue to Extras Button 
    [Documentation]    Clicks the continue to extras button
    Click    ${btnExtras}
    Wait Until Visible   ${btnPayment}
    
Select Room and Extras
    Wait Until Network Is Idle    #timeout=33s

Fill in Contact Information 
    [Arguments]    ${firstName}=Mos    ${lastName}=Def    ${phone}=040123942    ${ssn}=170479-371J    ${env}=bui
    [Documentation]    TBD: Use test data instead of hardcoded values
    ${rand}=    Helpers.Get Random Name
    ${email}=   Set Variable      ${emailUsername}-${rand}@${emailDomain} 
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email       ${email}
    Click and Fill    id=phoneNumber    ${phone}
    Run Keyword If    '${env}'=='bui'    Click and Fill    id=password    ${password}

Select Web Bank, Nordea as Payment Method 
    Click    //div[contains(text(), "Web bank payment")]
    Click    //p[contains(text(), 'Nordea')]
    Click    (//div[contains(@view,"payment")]//button[contains(text(), "Pay")])[1]

Fill in Payment Details
    [Arguments]    ${firstName}=Mos    ${lastName}=Def    ${phone}=040123942    ${ssn}=170479-371J    ${env}=bui
    [Documentation]    TBD: Use test data instead of hardcoded values
    Fill in Contact Information    ${firstName}    ${lastName}    ${phone}    ${ssn}    ${env}

    Run Keyword If    '${env}'=='bui'    Click    xpath=(//span[@class="chakra-checkbox__control css-6whjvh"])[2]
    Run Keyword If    '${env}'=='bui'    Click    //div[contains(text(), "Web bank payment")]
    Run Keyword If    '${env}'=='bui'    Click    //p[contains(text(), 'Nordea')]
    Run Keyword If    '${env}'=='bui'    Click    (//div[contains(@view,"payment")]//button[contains(text(), "Pay")])[1]
    Run Keyword If    '${env}'=='mui'    Click    //p[normalize-space()='Visa']
    Run Keyword If    '${env}'=='mui'    Click    (//button[normalize-space()='Pay'])[1]
    Run Keyword If    '${env}'=='mui'    Pay Using Visa

Complete Payment
    Simulate Success or Failure    success


Simulate Success or Failure
    [Arguments]    ${which}
    Wait For Elements State    //a[contains(text(), 'Simulate ${which} to merchant')]    visible    timeout=${timeout}
    Click    //a[contains(text(), 'Simulate ${which} to merchant')]
    Wait Until Network Is Idle

Close Dialog
    Wait Until Visible     //button[contains(text(), "Ok")]
    Click                  //button[contains(text(), "Ok")]

Pay Using Visa
    Wait Until Network Is Idle    timeout=33s
    Type Text    //label[@for='cardNumber']    4153013999700321
    Type Text    id=expiry    11/23
    Type Text    id=cvv    321
    Wait Until Network Is Idle    timeout=33s
    Click    //button[@type='submit']

Save Booking Number 
    ${str}=       Get Text    //p[contains(text(),'Booking number')]   
    ${no}=        Helpers.Strip Booking Number    ${str}
    Set Suite Variable     ${bookingNumber}    ${no}
    Log to Console         ${bookingNumber}

Verify Payment was successful
    Wait Until Visible     //p[contains(text(), 'Payment was successful')]
    Close Dialog
    Save Booking Number
    
Verify Booking is Successful
    Wait For Elements State    //div//h4    visible
    ${result}    Get Text    //div//h4
    Should Be Equal As Strings    ${result}    Payment was successful
    Click    //button[normalize-space()='Ok']
    ${result}    Get Text    //p[contains(text(),'Booking code')]
    ${result}    Remove String    ${result}    Booking code${SPACE}
    ${result}    Strip String    ${result}

Click Booker or Guest Name
    [Arguments]    ${name}
    Click    //p[contains(text(),'Mos Def')]

Verify Save and Sign State
    [Arguments]    ${turnOn}
    Run Keyword If    '${turnOn}'=='True'    Get Element Count    ${btnSaveAndSign}    ==    1
    Run Keyword If    '${turnOn}'=='True'    Get Element Count    ${btnSave}    <    1
    Run Keyword If    '${turnOn}'=='False'    Get Element Count    ${btnSaveAndSign}    <    1
    Run Keyword If    '${turnOn}'=='False'    Get Element Count    ${btnSave}    ==    1

Close Edit Booker or Guest
    Click    //button[@aria-label='Close']

Continue to Payment
    Click    (//button[normalize-space()='Continue to payment'])[1]

Check Regular Rate
    Click    //p[contains(text(),'Continue with regular rate')]
    Sleep    3

Fill Contact Info
    Click    //input[@id='firstName']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='firstName']    Long
    Click    //input[@id='lastName']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='lastName']    Tran
    Click    //input[@id='email']
    Type Text    //input[@id='email']    tdlong@tma.com.vn
    Click    //input[@id='phoneNumber']
    Type Text    //input[@id='phoneNumber']    324332333

Accept Term and Proceed to Payment
    Click    (//*[contains(text(),'Accept')]/ancestor::label//span[contains(@class,'chakra-checkbox__control')])[1]

Quick Pay
    Click    //div[normalize-space()='Web bank payment']
    Click    //p[normalize-space()='OP']
    BuiltIn.Sleep    6
    Click    (//button[normalize-space()='Pay'])[1]
    BuiltIn.Sleep    8

Verify Successful Booking
    Wait Until Keyword Succeeds    15s    3s    Wait For Elements State    //div//h4    visible
    ${result}    Get Text    //div//h4
    Should Be Equal As Strings    ${result}    Payment was successful
    Click    //button[normalize-space()='Ok']
    ${result}    Get Text    //p[contains(text(),'Booking code')]
    ${result}    Remove String    ${result}    Booking code${SPACE}
    ${result}    Strip String    ${result}

Check Join as Member
    Click    //p[contains(text(),'Join for free and')]

Quickly Pay
    Click    //div[normalize-space()='Web bank payment']
    Click    //p[normalize-space()='OP']
    Click    (//button[normalize-space()='Pay'])[1]

Select Hotel Turku, Humalistonkatu 
    Select Hotel    Turku, Humalistonkatu
    # Verify that the hotel is selected and not something else

Select Dates and Guests
    Choose Dates and Guests
    Click Book Button

Select Standard and Remove Other Room Selection 
    Click     //div[contains(text(), 'Select room')]
    Click     (//button[contains(text(), '1')])[1] 
    Click     //div[contains(text(), '1 room selected')]")[1]
    Click     //button[contains(text(), 'Remove')]")[1]

Select a Standard Room
    Wait Until Visible     ${btnExtras}   
    ${visible}=            Get Element States     //div[contains(text(), 'Select room')]    then    bool(value & visible) 
    Run Keyword If    ${visible}    Select Standard and Remove Other Room Selection

Verify Join for free is selected 
    Wait Until Visible  //input[@value='memberRate' and @checked='']  

Accept offers and Terms 
    Click   (//div[contains(text(), 'like to receive')])[1]
    #Click     (//div[contains(@class, 'chakra-stack')]//div[contains(text(), 'Accept')])[1]
    Click    (//*[contains(text(),'Accept')]/ancestor::label//span[contains(@class,'chakra-checkbox__control')])[1]
