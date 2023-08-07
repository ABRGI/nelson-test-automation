*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui_menu.resource
*** Keywords ***

Select Environment   
    [Arguments]    ${environment}
    IF     '${environment}' == '${EMPTY}'
        ${environment}=    Set Variable   Test (2) Omena
    END
    Click     //b[contains(@class, "client-name-color") and contains(text(), "${environment}")]
    # Verify env

Open Browser to Nelson Portal and Login
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Select Environment    ${environment}

Open Browser to Nelson Portal
    New Browser    ${browser}    ${headless}
    Set Browser Timeout    ${timeout}
    New Context
    New Page    ${MUI_URL}

Log in to Nelson Portal
    Fill Text       //*[@id='email']             %{MUI_USERNAME}
    Fill Text  //*[@id='password']          %{MUI_PASSWORD}
    Click    //button[contains(text(),'Sign in')]

Log in to Nelson Portal with Credentials
    [Arguments]    ${username}    ${password}
    Fill Text       //*[@id='email']             ${username}
    Fill Text  //*[@id='password']          ${password}
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
    Click Reservations from Navigation Menu

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

Select Hotel for Search 
    [Arguments]    ${hotel}
    Sleep    3s
    Click    (//button[@class='dropbtn'])[1]
    Sleep    3s
    Click     //li[contains(text(), '${hotel}')]

Click Search Button  
    Wait Until Network Is Idle
    Click      //button[contains(text(), 'Search')]
    Wait Until Network Is Idle
    Wait Until Visible    //th[contains(@class, 'sortActive')]

Toggle Check in incomplete filter button
   Wait Until Keyword Succeeds    10s    2s    Toggle Filter    incomplete
   
Select First Guest Info Table
    ${table}=   Get Element     (//table[contains(@class, 'custom-table')])[3]
    [Return]    ${table}

Get State    
    [Arguments]    ${element}
    ${state}=     Get Element States    ${element}    validate    value
    [Return]    ${state}

Select Reservation with Check in Incomplete
    [Documentation]    This keyword selects the first reservation with check in incomplete
    ...                and verifies the green icon and checkmark are shown
    ...                NOTE! Needs more verifications as the mouseover is a bit hard to verify
    ${col0cell1}=    Get Table Cell Element    ${muiResultTable}    0    1      
    Click        ${col0cell1}
    #Verify the check in status is not shown
    Wait Until Network Is Idle

Select Reservation with Check in Complete
    Log To Console     To Be Implemented
    # Create a way to select first/last/some of the reservations

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

Verify Dashboard Elements 
    Click First Element Found      (//a[contains(@href, "dashboard")])[2]