*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource

*** Variables ***

${muiResultTable}     //table[contains(@class, 'custom-table')]
${environment}        Test (2) Omena
${MUI_USERNAME}        %{MUI_USERNAME}
${MUI_PASSWORD}        %{MUI_PASSWORD}
*** Keywords ***

Select Environment   
    [Arguments]    ${environment}
    Click     //b[contains(@class, "client-name-color") and contains(text(), "${environment}")]
    # Verify env

Open Browser to Nelson Portal and Login
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Select Environment    ${environment}

Open Browser to Nelson Portal and Navigate to Test Exhibition
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Select Environment    Test Exhibition

Open Browser to Nelson Portal
    New Browser    ${browser}    ${headless}
    Set Browser Timeout    ${timeout}
    New Context
    New Page        %{MUI_URL}

Log in to Nelson Portal
    Type Secret    //*[@id='email']         $MUI_USERNAME
    Type Secret  //*[@id='password']      $MUI_PASSWORD
    Click    //button[contains(text(),'Sign in')]

Click First Search Result Row 
    Click     (//tr)[1]

Assert Reservationd View is Open 
    [Arguments]    ${filter}
    ${visibility}  Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    Get Element     //div[contains(text(), '${filter}')]
    ${result}=   Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    IF     ${visibility} == 'visible'     # --> Toggle OFF
        Click    //div[contains(text(), '${filter}')]
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
        
    ELSE IF     ${visibility} == 'hidden'     # --> Toggle ON
        Click    //div[contains(text(), '${filter}')]
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
    END

Create Booking, Check in and get UUID    
    ${uuid}=     Create a successful booking and return UUID
    Set suite variable    ${bookingUUID}    ${uuid}
    Click Check In Button
    Fill Check in Slide
    Click Save and Sign Button and Sign if Required
    Complete Check in
    Close Browser

Open Reservations Page
    Click     //ul[@class='nav']/li/a[@href='#/reservations']

Click New Reservation Button 
    Click     //button[contains(text(), 'New Reservation')]

Select Normal Reservation 
    Click       (//input[@name='type-selection'])[1]
    Click       //button[contains(text(),'Create')]

Select Group Reservation
    Click       (//input[@name='type-selection'])[2]
    Click       //button[contains(text(),'Create')]

Search with String
    [Arguments]    ${searchText}
    Click         //input[contains(@class, "searchQuery")]
    Sleep     2s
    Fill Text    //input[contains(@class, "searchQuery")]     ${searchText}
    Sleep     2s
    Click Search Button

Click Search Button  
    Click      //button[contains(text(), 'Search')]
    Wait Until Visible    //th[contains(@class, 'sortActive')]

Toggle Check in incomplete filter button
    Toggle Filter   incomplete

Select First Guest Info Table
    ${table}=   Get Element     (//table[contains(@class, 'custom-table')])[3]
    [Return]    ${table}

Is Visible
    [Arguments]    ${element}
    ${visible}=     Get Element States    ${element}    validate    value
    [Return]    ${visible}

Select Reservation with Check in Incomplete
    [Documentation]    This keyword selects the first reservation with check in incomplete
    ...                and verifies the green icon and checkmark are shown
    ...                NOTE! Needs more verifications as the mouseover is a bit hard to verify
    ${col0cell1}=    Get Table Cell Element    ${muiResultTable}    0    1      
    Click        ${col0cell1}
    #Verify correct reservation is shown
    ${isVisible}=    Is Visible     (//div[contains(@class, 'checkin-status')])[0]
    IF     ${isVisible}      
        #Click   ${isVisible}
        Wait Until Visible    (//div[contains(@class, 'checkin-item-check')][0]
    ELSE
        #Verify Check in status is not shown when hovering on Guest name
        
        ${col0cell1}=    Get Table Cell Element    ${table}    0    1    
        #Add a check
    END

Select Reservation with Check in Complete
    Pass Execution     TBD
    # Create a way to select first/last/some of the reservations
    Verify correct reservation is shown
    Verify Check in status is shown when hovering on Guest name

Go back to reservations
    Pass Execution    TBD
    Click ${reservations_menu_button}
    Verify button is shown with the highlight color
    Verify button has a checkmark # This seems to be the expected behaviour to keep the filter

Get Icon Visibility
    [Arguments]    ${filter}
    Get Element     //div[contains(text(), '${filter}')]
    ${result}=   Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    [Return]    ${result}

Toggle Filter
    [Arguments]    ${filter}=incomplete    
    [Documentation]    This keyword toggles the filter on or off and verifies the icon is showing or not showing
    ...                By giving the filter an argument, it can be used to all filters on the page.
    ${visibility}=   Get Icon Visibility    ${filter}
    IF     "${filter}" == 'incomplete'
        Click    (//div[@class="filter-radio"])[5]
        Check button design    ${filter}    ${visibility}
    ELSE     
        Pass Execution     TBD
    END 

Check button design
    [Arguments]        ${filter}    ${visibility}
    IF     "${visibility}" == 'visible'     # --> Toggle OFF
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden

    ELSE IF     "${visibility}" == 'hidden'     # --> Toggle ON
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
    END
    
Open A MUI Client
    [Arguments]    ${client}
    Click    //b[normalize-space()='${client}']

New Reservation MUI
    Wait Until Network Is Idle    timeout=33s
    Click    //button[normalize-space()='New Reservation']

Create New Reservation MUI
    Wait Until Visible    //button[normalize-space()='Create']
    Wait Until Keyword Succeeds    10s    2s    Click    //button[normalize-space()='Create']

Log out of Nelson Portal
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Wait For Elements State    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img

Find Room
    Click    //button[normalize-space()='Find rooms']

Log out of Nelson In BUI Confirmation Page
    Click    //p[normalize-space()='Sign out']

# Reservation page - should be moved to a separate resource file 
Click View Guests Button
    Click         //button[contains(text(), " View guests")]