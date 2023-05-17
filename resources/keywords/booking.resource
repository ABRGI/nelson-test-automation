*** Settings ***
Documentation       This file contains keywords that are related to the booking process.

Library             ${EXECDIR}/resources/libraries/Helpers.py
Resource            ${EXECDIR}/resources/variables/variables.resource
Resource            ${EXECDIR}/resources/keywords/common.resource
Resource            ${EXECDIR}/resources/variables/locators.resource
Library             Browser
Library             String


*** Keywords ***
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

Click Cancel
    [Documentation]    Clicks the cancel button
    Click    //footer/button[text()="Cancel"]

Signature modal is visible
    [Documentation]    Verifies the signature modal is visible
    Wait Until Visible    id=chakra-modal--body-115

Fill in Other Guest Details
    [Documentation]    Fills in other guest details, which can be given as arguments or uses default values
    [Arguments]
    ...    ${firstName}=Snoop
    ...    ${lastName}=Dogg
    ...    ${email}=nelsontestar@gmail.com
    ...    ${phone}=040123942
    ...    ${ssn}=170479-371J
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
    [Documentation]    Selects the number of guests for the booking, current implementation will only check the dropdown    
    [Arguments]    ${rooms}=1    ${persons}=1    ${children}=0
    Wait Until Visible    //div[contains(@data-nelson-btn, 'guests')]
    Click    //div[contains(@data-nelson-btn, 'guests')]
    #Click    //div[contains(@data-nelson-btn, 'guests')]
    # Click    (//button[contains(@data-nelson-guests-add, 'rooms')])[1]

Choose Dates and Guests
    Select Guests
    Click    //button[@class="booking-form-button btn btn-primary"]
    Wait For Elements State    ${btnExtras}    visible    timeout=${timeout}

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



Select Room and Extras
    Wait Until Network Is Idle    timeout=33s
    Click    ${btnExtras}
    Wait For Elements State    ${btnPayment}    visible    timeout=${timeout}
    Click    ${btnPayment}

Fill in Payment Details
    [Documentation]    TBD: Use test data instead of hardcoded values
    [Arguments]
    ...    ${firstName}=Mos
    ...    ${lastName}=Def
    ...    ${phone}=040123942
    ...    ${ssn}=170479-371J
    ...    ${env}=bui
    ${rand}=    Helpers.Get Random Name
    Click and Fill    id=firstName    ${firstName}
    Click and Fill    id=lastName     ${lastName}
    Click and Fill    id=email        ${emailUsername}-${rand}@${emailDomain}
    Click and Fill    id=phoneNumber  ${phone}
    Run Keyword If    '${env}'=='bui'    Click and Fill    id=password     ${password}
    Run Keyword If    '${env}'=='bui'    Click    xpath=(//span[@class="chakra-checkbox__control css-6whjvh"])[2]
    Run Keyword If    '${env}'=='bui'    Click    //div[contains(text(), "Web bank payment")]
    Run Keyword If    '${env}'=='bui'    Click    //p[contains(text(), 'Nordea')]
    Run Keyword If    '${env}'=='bui'    Click    (//div[contains(@view,"payment")]//button[contains(text(), "Pay")])[1]
    Run Keyword If    '${env}'=='mui'    Click    //p[normalize-space()='Visa']
    Run Keyword If    '${env}'=='mui'    Click    (//button[normalize-space()='Pay'])[1]
    Run Keyword If    '${env}'=='mui'    Pay Using Visa

Simulate Success or Failure
    [Arguments]    ${which}
    Wait For Elements State    //a[contains(text(), 'Simulate ${which} to merchant')]    visible    timeout=${timeout}
    Click    //a[contains(text(), 'Simulate ${which} to merchant')]

Close Dialog
    Wait For Elements State    id=chakra-modal-4    visible    timeout=${timeout}
    Click    //footer/button[contains(text(), "Ok")]

Pay Using Visa
    Wait Until Network Is Idle    timeout=33s
    Type Text    //label[@for='cardNumber']    4153013999700321
    Type Text    id=expiry    11/23
    Type Text    id=cvv    321
    Wait Until Network Is Idle    timeout=33s
    Click    //button[@type='submit']

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
