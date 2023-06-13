*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Library           Browser    auto_closing_level=SUITE
Library           String

*** Keywords ***

Complete a new booking
    [Documentation]    A complete booking process from start to finish
    ...                This is currently duplicate to "Create a new booking" test case 
    Open Browser to Landing Page
    Select Hotel
    Select Dates
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button
    Continue to Payment
    Select Join for Free
    Fill in Contact Information 
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully

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

Open Link from Email 
    [Arguments]         ${link}
    Open New Browser To URL    ${link}

Verify edit booking page
    [Documentation]    Verifies the edit booking page is opened with correct values 
    Pass Execution     TBD: Should be implemented

Signature modal is visible
    [Documentation]    Verifies the signature modal is visible
    Wait Until Visible    id=chakra-modal--body-115

Fill in Other Guest Details
    [Arguments]    ${firstName}=Snoop    ${lastName}=Dogg    ${email}=nelsontestar@gmail.com    ${phone}=040123942    ${ssn}=170479-371J
    [Documentation]    Fills in other guest details, which can be given as arguments or uses default values
    ${inbox}=         Create Email and Return Inbox
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email    ${inbox.email_address}
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
    Click First Element Found    //div[@class='css-1t415z1']//button[@type='button'][normalize-space()='Continue to payment']
    ##Wait Until Visible   ${btnPayment}

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
    ${inbox}=         Create Email Address
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email    ${inbox.email_address}
    Click and Fill    id=phoneNumber    ${phone}
    Log To Console    ${inbox.id}
    Set Suite Variable      $ID     ${inbox.id}
    # We need to save the email id in order to be able to use it in the next step of verifying the email
    Run Keyword If    '${env}'=='bui'    Click and Fill    id=password    ${password}

Fill in Contact Information 1
    [Arguments]    ${firstName}=Bich    ${lastName}=Ngoc    ${phone}=040123942    ${ssn}=170479-371J    ${env}=bui  ${email}=bichngoc9995@gmail.com
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email       ${email}
    Click and Fill    id=phoneNumber    ${phone}

Select Web Bank and Nordea as Payment Method 
    Click    //div[contains(text(), "Web bank payment")]
    Click    //p[contains(text(), 'Nordea')]
    Click    (//div[contains(@view,"payment")]//button[contains(text(), "Pay")])[1]

Click Check In Button
    Wait Until Visible    (//button[text()="Check in"])[1]
    Click                 (//button[text()="Check in"])[1]
    
Sign 
    Click    (//button[@aria-label='Close']/following-sibling::div/div)[1]
    ${j}    Set Variable    1
    FOR    ${i}    IN RANGE    42
        Mouse Move Relative To    (//button[@aria-label='Close']/following-sibling::div/div)[1]    -10    ${j}
        Mouse Button    down
        Mouse Button    up
        ${j}    Evaluate    ${j} + 1
    END
    Wait Until Visible    //canvas
    Click             //div[contains(@class, 'chakra-modal__body')]
    Click         //button[text()='Save']
    Wait For Elements State     //div[contains(@class, 'chakra-modal__body')]       hidden    timeout=${timeout}

Click Save and Sign Button
    Click                 //button[contains(text(), "Save and Sign")]

Complete Check in    
    Wait Until Visible    //p[contains(text(), "completed")]

Fill Check in Slide 
    Wait Until Visible    (//div[contains(@class, "chakra-offset-slide")])[2]
    Fill Text             id=firstName     ${firstName}
    Fill Text             id=lastName     ${lastName}
    Fill Text             id=ssn         ${ssn}
    # TBD: Should be dynamic test data not hardcoded
    Fill Text             id=address         Susitie 5
    Fill Text                id=city         Paimio  
    Fill Text                id=postalCode     21530
    Click             //span[contains(text(), "Travelling for work")]


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

Complete Payment Successfully
    Simulate Success or Failure    success
    Verify Payment was successful

Simulate Success or Failure
    [Arguments]    ${which}
    Wait For Elements State    //a[contains(text(), 'Simulate ${which} to merchant')]    visible    timeout=${timeout}
    Click    //a[contains(text(), 'Simulate ${which} to merchant')]

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
Save Booking Number 1
    ${str}=       Get Text    //p[contains(text(),'Booking number')]   
    Log to Console         ${bookingNumber}
    ${str}    Remove String    ${str}    Booking code${SPACE}
    ${str}    Strip String    ${str}
    

Verify Payment was successful
    Wait Until Visible     //p[contains(text(), 'Payment was successful')]
    Close Dialog
    Save Booking Number 1
    
Verify Booking is Successful
    Wait For Elements State    //div//h4    visible
    ${payment_result}    Get Text    //div//h4
    Should Be Equal As Strings    ${payment_result}    Payment was successful
    Click    //button[normalize-space()='Ok']

Verify Booking is Successful and return result
    Verify Booking is Successful
    ${result}    Get Text    //p[contains(text(),'Booking code')]
    ${result}    Remove String    ${result}    Booking code${SPACE}
    ${result}    Strip String    ${result}

Verify Confirmation Email is Received
    [Arguments]    ${inbox}
    [Documentation]    Verifies that the confirmation email is received, requires a Mailslurp inbox as an argument
    ${link}=     Read Email and Return Link    ${inbox}
    Log to Console    ${link}
    # TODO: Verify content of the email
    Open New Browser To URL    ${link}

Create a successful booking and return UUID
    Complete a new booking
    Wait Until Network Is Idle
    ${url}       Get Url
    ${uuid}=     Extract Guid From Url    ${url}
    [Return]    ${uuid}

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
    Wait Until Visible   //div//*[normalize-space()='Continue with regular rate']/following-sibling::div[@data-checked]
    #Wait For Elements State    //input[@type='password']    hidden
Check Regular Rate 2
    Check Regular Rate
    Check Join as Member
    Check Regular Rate
    Check Join as Member
    Check Regular Rate
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
    Click    (//button[normalize-space()='Pay'])[1]
    Wait For Elements State    //p[normalize-space()='Payment was successful']    visible    timeout=12s

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
    Wait Until Visible   //div//*[normalize-space()='Join for free and get the member rate']/following-sibling::div[@data-checked]
    #Wait For Elements State    //input[@type='password']    visible

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

Select Join for Free
    Wait Until Visible  //input[@value='memberRate' and @checked='']  
    Wait Until Visible   //div//*[normalize-space()='Join for free and get the member rate']/following-sibling::div[@data-checked]

Accept offers and Terms 
    Click   (//div[contains(text(), 'like to receive')])[1]
    #Click     (//div[contains(@class, 'chakra-stack')]//div[contains(text(), 'Accept')])[1]
    Click    (//*[contains(text(),'Accept')]/ancestor::label//span[contains(@class,'chakra-checkbox__control')])[1]

Fill In Booker info
   Click    //input[@id='ssn'] 
   Wait Until Visible   //input[@id='ssn']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='ssn']    020202-0202
   Click    //input[@id='city']
   Wait Until Visible  //input[@id='city']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='city']    Tokyo
   Click    //input[@id='address']
   Wait Until Visible   //input[@id='address']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='address']    Paul Street
   Click   //input[@id='postalCode']
   Wait Until Visible   //input[@id='postalCode']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='postalCode']    10000
   Wait Until Visible   //button[normalize-space()='Save and invite']
Click Someone else checkbox
   Click   //span[normalize-space()='Someone else will be the main guest']
Click Save and invite
   Click   //button[normalize-space()='Save and invite']
   Wait Until Visible   //button[normalize-space()='Save and invite']
Wait for invite guest page
   [Arguments]    ${shown}
   run keyword If    ${shown == ${True}}    Wait For Elements State    //button//*[@data-icon='xmark']    visible
   run keyword If    ${shown == ${True}}    Wait For Elements State    //button[normalize-space()='Cancel']    visible
   run keyword If    ${shown == ${False}}    Wait For Elements State    //button//*[@data-icon='xmark']    hidden
   run keyword If    ${shown == ${False}}    Wait For Elements State    //button[normalize-space()='Cancel']    hidden
Fill Invite guest info and click invite button
   Wait Until Visible   //div[contains(@class,'chakra-offset-slide')]//form
   Click   //input[@id='firstName']
   Wait Until Visible   //input[@id='firstName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='firstName']    Shin 
   Click   //input[@id='lastName']
   Wait Until Visible   //input[@id='lastName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='lastName']    Suke
   Click   //input[@id='email']
   Wait Until Visible   //input[@id='email']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='email']    shinsuke@gmail.com
   Click   //button[normalize-space()='Invite']
Open Edit booker info
   ##Wait Until Network Is Idle    timeout=4s
   Click   //p[text()='Booked by']
Verify All information is disbled
   #email is not modifiable
   Verify Element Presence    //input[@id='email' and @disabled]    ${True}
   Wait Until Keyword Succeeds    20s    2s    Verify Element Presence    //input[@id='firstName' and @disabled]    ${True}
   Verify Element Presence    //input[@id='lastName' and @disabled]    ${True}
   Verify Element Presence    //input[@id='ssn' and @disabled]    ${True}
   Verify Element Presence    //input[@id='city' and @disabled]    ${True}
   Verify Element Presence    //input[@id='address' and @disabled]    ${True}
   Verify Element Presence    //input[@id='postalCode' and @disabled]    ${True}
   ${style}    Get Attribute   //input[@id='phoneNumber']/parent::div    style
   Should Be true     '${style}' == 'border-color: rgb(153, 163, 182);'
   ##Type Text    //input[@id='phoneNumber']    020202-0202

   #Fill Text      //input[@id='phoneNumber']    433434

   ## Verify Element Presence    //input[@id='email' and @disabled]    ${False} 
Check Add organization check box
   Click   //span[text()="Add organization information for receipt"]
   Click   //input[@id='companyName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyName']    TMA
   Click   //input[@id='companyRef']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyRef']    TMAa
   Click   //input[@id='companyVat']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyVat']    TMAs
   Click   //span[text()="Add organization information for receipt"]
   Verify Element Presence    //input[@id='companyName']    ${False}
   Verify Element Presence    //input[@id='companyRef']    ${False}
   Verify Element Presence    //input[@id='companyVat']    ${False}
   ##Wait For Elements State   //span[text()="Add organization information for receipt"]   visible
   #Click   //span[text()="Add organization information for receipt"]
   Click   //button[normalize-space()='Save']
Fill organization info
   Click   //input[@id='companyName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyName']    TMA
   Wait For Elements State   //input[@id='companyRef']   visible
   Click   //input[@id='companyRef']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyRef']    TMAa
   Click   //input[@id='companyVat']
   Wait For Elements State   //input[@id='companyVat']   visible
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='companyVat']    TMAs
   Click   //button[normalize-space()='Save']
Verify all information are save
   Click   //p[text()='Booked by']
   Verify Element Presence    //input[@id='firstName' and @disabled]    ${True}
   Wait Until Keyword Succeeds    10s    2s    Verify Element Presence    //input[@id='lastName' and @disabled]    ${True}
   Verify Element Presence    //input[@id='email' and @disabled]    ${True}
   Verify Element Presence    //input[@id='ssn' and @disabled]    ${True}
   Verify Element Presence    //input[@id='city' and @disabled]    ${True}
   Verify Element Presence    //input[@id='address' and @disabled]    ${True}
   Verify Element Presence    //input[@id='postalCode' and @disabled]    ${True}
   Click   //span[text()="Add organization information for receipt"]
   Verify Element Presence    //input[@id='companyName' and @disabled]    ${False}
   Verify Element Presence    //input[@id='companyRef' and @disabled]    ${False}
   Verify Element Presence    //input[@id='companyVat' and @disabled]    ${False}
   Click    //button//*[name()='svg' and @data-icon="xmark"]
Verify Element Presence
    [Arguments]    ${path}    ${shown}
    ${check}    Run Keyword And Return Status    Wait For Elements State    ${path}    visible    timeout=6
    Run Keyword If    ${shown} == ${true}    Should Be True    ${check}==${True}
    Run Keyword If    ${shown} == ${false}    Should Be True    ${check}==${False}
Verify msg The field is required
    Verify Element Presence    //input[(@id='ssn')]/parent::div//div[normalize-space()='This field is required!' and @disabled]    ${False}
    Verify Element Presence    //input[(@id='city')]/parent::div//div[normalize-space()='This field is required!' and @disabled]     ${False}
    Verify Element Presence    //input[(@id='address')]/parent::div//div[normalize-space()='This field is required!' and @disabled]     ${False}
    Verify Element Presence    //input[(@id='postalCode')]/parent::div//div[normalize-space()='This field is required!' and @disabled]     ${False}

Fill invalid phone format
    Click    //input[@id='phoneNumber']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='phoneNumber']    suke6545
Verify msg "Invalid phone number!"
    Verify Element Presence     //div[text()='Invalid phone number!' and @disabled]    ${False}
Fill invalid SSN
    Click    //input[@id='ssn']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='ssn']    suke6545
Verify msg "Please check! This is not a Finnish social security number"
    Verify Element Presence     //div[text()='Please check! This is not a Finnish social security number' and @disabled]    ${False}

Fill contact info with the National not Finland
   [Arguments]    ${firstName}=Mos    ${lastName}=Def    ${phone}=915036410    ${ssn}=170479-371J    ${env}=bui  ${email}=bichngoc9995@gmail.com
   [Documentation]    TBD: Use test data instead of hardcoded values
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName    ${lastName}
    Click and Fill    id=email       ${email}
    Click   //p[text()="Enter your info"]/ancestor::form//*[name()='svg']
    Click   //p[normalize-space()='(+84) Vietnam']
    Click and Fill    id=phoneNumber    ${phone}
Fill Booker Info with the national is not Finland
   Click    //input[@id='passportNumber']   
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='passportNumber']    A42354623546235
   Click    //input[@id='city']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='city']    HCM
   Click    //input[@id='address']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='address']    To Ky
   Click   //input[@id='postalCode']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='postalCode']    70000
   Click   //button[normalize-space()='Save and Sign']

Verify booker information with national
   Verify Element Presence  //input[@id='passportNumber']  ${True}
   Verify Element Presence  //input[@id='city']  ${True}
   Verify Element Presence  //input[@id='address']  ${True}
   Verify Element Presence  //input[@id='postalCode']  ${True}
Click save button in Signature
   Click   //button[normalize-space()='Save']
Click Save and Sign Button 2
   Wait Until Visible   //button[normalize-space()='Save and Sign']
   Click   //button[normalize-space()='Save and Sign']

Edit guest popup change to "Booker information"
   Verify Element Presence  //div[normalize-space()='Booker information' and @disabled]   ${False}
Verify notification "Before iniviting someone else to be the main guest in this room, you must fill in your own information"
   Verify Element Presence   //div[normalize-space()='Before inviting someone else to be the main guest in this room, you must fill in your own information.' and @disabled]  ${False} 
Room name is removed
   Verify Element Presence    //div[contains(@class,'guest-modal')]//p[normalize-space()='Standard room' ]    ${False}
The "Purpose of the trip" checkbox is removed
   Verify Element Presence     //span[text()='Travelling for work']   ${False}
The "Save and sign" button changes to " Save and invite" button
   Verify Element Presence  //button[normalize-space()='Save and Sign']    ${False}
   Verify Element Presence  //button[normalize-space()='Save and invite']   ${True}
Booker just completed payment for a reservation   
    Select Hotel     Helsinki, Lönnrotinkatu
    Select Dates 
    Select Guests
    Click Book Button
    Select a Standard Room
    Click Continue to Extras Button 
    Click Continue to Payment
    Check Regular Rate 2
    Fill in Contact Information 1
    Accept offers and Terms
    Select Web Bank and Nordea as Payment Method
    Complete Payment Successfully

Invite guest popup is open
    Verify Element Presence  //p[text()='Invite guest']/ancestor::div[@class="chakra-offset-slide"]  ${True}
Verify the Invite Guest UI
    Verify Element Presence  //p[text()='Invite guest']/ancestor::div[@class="chakra-offset-slide"]  ${True}
    Verify Element Presence  //form/div/p   ${True}
    Verify Element Presence  //input[@id='firstName']  ${True}
    Verify Element Presence  //input[@id='lastName']  ${True}
    Verify Element Presence  //input[@id='email']  ${True}
    Verify Element Presence  //button[normalize-space()='Cancel']  ${True}
    Verify Element Presence  //button[normalize-space()='Invite']  ${True}
    Verify Element Presence  //div//button//*[name()='svg' and @data-icon='xmark']  ${True}
Verify email with valid email
    Click      //input[@id='email']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='email']    example@example.com
    ##Verify Element Presence    //input[(@id='email')]/parent::div//div[normalize-space()='This field is required!' and @disabled]    ${True}
Verify email with invalid email
    Click      //input[@id='email']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='email']    example21423example.com
    Verify Element Presence    //input[(@id='email')]/parent::div//div[normalize-space()='This field is required!' and @disabled]    ${False}
Fill invite guest info with block guest email
    Wait Until Visible   //div[contains(@class,'chakra-offset-slide')]//form
    Click   //input[@id='firstName']
    Wait Until Visible   //input[@id='firstName']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='firstName']    User
    Click   //input[@id='lastName']
    Wait Until Visible   //input[@id='lastName']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='lastName']    blocktest
    Click   //input[@id='email']
    Wait Until Visible   //input[@id='email']
    Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='email']    blockuserfortest@gmail.com
    Click   //button[normalize-space()='Invite']
Verify Warning Popup is displayed with blocker email
    Verify Element Presence    //button[normalize-space()='Close']  ${True}
    Verify Element Presence   //p[contains(text(),'This email address has been blocked, please change')]  ${True}
    Verify Element Presence  //p[contains(text(),'Cannot invite')]  ${True}
    Verify Element Presence  //img[contains(@src,'/en/booking/resources/images/uninvite-bell.png')]    ${True}
Verify Warning Popup is displayed with booker email
    Verify Element Presence    //button[normalize-space()='Close']  ${True}
    Verify Element Presence   //p[contains(text(),'Other guests or booker already used this email address, please change it')]  ${True}
    Verify Element Presence  //p[contains(text(),'Cannot invite')]  ${True}
    Verify Element Presence  //img[contains(@src,'/en/booking/resources/images/uninvite-bell.png')]    ${True}
Fill invite guest infor with booker email
   Wait Until Visible   //div[contains(@class,'chakra-offset-slide')]//form
   Click   //input[@id='firstName']
   Wait Until Visible   //input[@id='firstName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='firstName']    user01 
   Click   //input[@id='lastName']
   Wait Until Visible   //input[@id='lastName']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='lastName']    invited
   Click   //input[@id='email']
   Wait Until Visible   //input[@id='email']
   Wait Until Keyword Succeeds    20s    2s    Type Text    //input[@id='email']    bichngoc9995@gmail.com
   Click   //button[normalize-space()='Invite']
Close Warning popup
   Click   //button[normalize-space()='Close']
Click Cancel button
   Click   //button[normalize-space()='Cancel']
Booker is brought back to Comfirmation Landing page
   Wait For Elements State    //button[normalize-space()='Cancel']    hidden
Notice "Invite sent" displays
   Wait For Elements State    //p[normalize-space()='Invite sent']    visible
Status of guest confirmation is changed to "Invite sent, not check-in"
   Wait For Elements State   //p[text()='Invite sent, checked-in not complete!']   visible
Verify Guest information component
   Wait For Elements State   //p[text()='Invite sent, checked-in not complete!']   visible
Verify Booking summary  
   Wait For Elements State   //p[text()='room']   visible
   Wait For Elements State   //p[text()='Booked by']   visible
   Wait For Elements State   //button[normalize-space()='Download full receipt']   visible
   Wait For Elements State   //p[text()='Booking number']   visible
   Wait For Elements State   //a[@rel='noopener noreferrer']   visible
   Wait For Elements State   //button[normalize-space()='My bookings']   visible
Verify Configurable secondary banner
   Verify Element Presence  //p[text()='Download our new app!']  ${True}
   Verify Element Presence  //p[text()='This app makes booking and your stay at Omena Hotels more convenient.']  ${True}
   Verify Element Presence  (//img[@alt='app store'])[1]  ${True}
   Verify Element Presence  (//img[@alt='google store'])[1]  ${True}
Verify Guest information popup when guest not checkin
   Click   (//*[name()='svg'][@role='img'])[4]
   Verify Element Presence    //p[text()='Guest information']    ${True}
   Verify Element Presence  //input[@id='firstName']   ${True}
   Verify Element Presence  //input[@value="Shin" and @disabled]   ${True}
   Verify Element Presence  //input[@id='lastName']   ${True}
   Verify Element Presence  //input[@value="Suke" and @disabled]   ${True}
   Verify Element Presence  //input[@id='email']   ${True}
   Verify Element Presence  //input[@value="shinsuke@gmail.com" and @disabled]   ${True}
   Verify Element Presence  //button[normalize-space()='Cancel']    ${True}
   Verify Element Presence  //button[normalize-space()='Uninvite']   ${True}
Click Uninvite button
   Click   //button[normalize-space()='Uninvite']
Verify Uninvite warning popup
   Verify Element Presence  //p[text()='Uninvite']  ${True}
   Verify Element Presence  //p[text()='Are you sure you want to uninvite shinsuke@gmail.com ']   ${True}
   Verify Element Presence  (//button[@type='button'][normalize-space()='Cancel'])[2]    ${True}
   Verify Element Presence  (//button[@type='button'][normalize-space()='Uninvite'])[2]    ${True}
Click Univite button in Uninvite warning popup
   Click   (//button[@type='button'][normalize-space()='Uninvite'])[2]
Edit guest popup is open
    Verify Element Presence  //p[text()="Invite guest"]/ancestor::div[@class="chakra-offset-slide"]   ${True}

