*** Settings ***


Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/variables/locators.resource
Library            Browser

*** Keywords ***

## Keywords used by specs 

A new booker makes a reservation
    Select Hotel
    Choose Dates and Guests
    Select Room and Extras
    
Successfully completes a payment
    Fill in Payment Details 
    Simulate Success or Failure        success

Booker clicks on booker information
    Click     (//p[contains(text(), "Details needed for receiving")])[1]

Booker clicks on main guest name 
    Click     (//p[contains(text(), "Details needed for receiving")])[2]

Edit guest page is opened
    Wait Until Visible         id=chakra-modal-114

Save and Sign button is visible 
    Wait Until Visible         //button[@data-ga4-event="add_guest_information"]

Toggle Someone Else Checkbox
    Click                 //span[contains(text(),"Someone else")]

Click Cancel 
    Click                     //footer/button[text()="Cancel"]

Signature modal is visible 
    Wait Until Visible     id=chakra-modal--body-115

Fill in Other Guest Details 
    #TBD: Should use test data instead of hard coded values
    Click and Fill    id=firstName    ${firstName2}
    Click and Fill    id=lastName    ${lastName2}
    Click and Fill    id=email    ${email}
    Click and Fill    id=phone    ${phone}  
    #${ssn}=         Generate SSN  
    Click and Fill    id=ssn    ${ssn}

Click Save and Sign
    Click             //button[@data-ga4-event="add_guest_information"]



Text on the save button is displayed as "${expected_text}"
    ${save_button_text}=          Get Text               xpath=//button[contains(text(),'Save and Sign')]
    Should Be Equal As Strings    ${save_button_text}    ${expected_text}

Booker navigates to edit guest page
    Pass Execution    Implementation code to complete a payment

Marks the "Someone else will be the main guest" checkbox as <value>
    Pass Execution    Implementation code to complete a payment

## Keywords used in scripts 
Choose Dates and Guests 
    Select Guests 
    Click    //button[@class="booking-form-button btn btn-primary"]
    Wait For Elements State     ${btnExtras}    visible     timeout=${timeout}

Select Hotel 
    [Arguments]        ${hotel}=Lönnrotin
    [Documentation]    Select Hotel by using a number as an argument, default 6 (Tampere)
    Log                Selecting Hotel: ${hotel}
    Click              //div[contains(@data-nelson-btn, "hotels")]
    Sleep   2s
    Click             (//a[contains(@class, 'dropdown-item') and contains(text(), '${hotel}')])
    Sleep   2s

Select Dates 
    [Documentation]    TBD
    Click    //div[contains(@class, 'booking-form-dates')]
    ${container}=    Get Element     //div[@class="container__months"]
    ${html}=     Get Property        ${container}    innerHTML
    Log   ${html}
    @{elements}=     Get Elements    //div[@class="day-item"]
    ${selected}=     Set Variable    1
        FOR     ${e}     IN     @{elements}
            ${visibility}=     Get Element States    ${e}   then    value & (visible | hidden)
            IF     ${visibility} == 'visible'
                Click     ${e}
                ${selected}=     Set Variable     ${selected} + 1
            END
            ${both}=     Evaluate    ${selected} > 2
            Exit For Loop If    ${both}
        END

Select Guests 
    [Arguments]    ${rooms}=1    ${persons}=1    ${children}=0
    [Documentation]    
    Click     //div[contains(@class, 'booking-form-guests')]/button
    #Click     (//button[contains(@data-nelson-guests-add, 'rooms')])[1]

Select Room and Extras
    Click    ${btnExtras}
    Wait For Elements State    ${btnPayment}    visible    timeout=${timeout}
    Click     ${btnPayment}

Fill in Payment Details 
    [Documentation]    TBD: Use test data instead of hardcoded values
    ${rand}=     Helpers.Get Random Name
    Click and Fill      id=firstName     ${firstName}
    Click and Fill      id=lastName        ${lastName}
    Click and Fill      id=email           saragee+nelson-${rand}@gmail.com
    Click and Fill      id=phoneNumber     ${phone}
    Click and Fill      id=password        ${password}
    Click         xpath=(//span[@class="chakra-checkbox__control css-6whjvh"])[2]
    Click         //div[contains(text(), "Web bank payment")]
    Click         //p[contains(text(), 'Nordea')]
    Click         (//div[contains(@view,"payment")]//button[contains(text(), "Pay")])[1]

Simulate Success or Failure
    [Arguments]        ${which}
    Wait For Elements State    //a[contains(text(), 'Simulate ${which} to merchant')]    visible     timeout=${timeout} 
    Click                     //a[contains(text(), 'Simulate ${which} to merchant')]

Close Dialog 
    Wait For Elements State     id=chakra-modal-4    visible     timeout=${timeout} 
    Click                       //footer/button[contains(text(), "Ok")]
