*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource

Library           String 

*** Variables ***

${muiResultTable}     //table[contains(@class, 'custom-table')]

*** Keywords ***

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
    Click Save and Sign Button
    Sign
    Complete Check in
    Close Browser

Open reservations page
    Pass Execution    Add code

Click Search Button  
    Click      //button[contains(text(), 'Search')]

Toggle Check in incomplete filter button
    Toggle Filter   incomplete

Select Reservation with Check in Incomplete
    Wait Until Network Is Idle
    ${col0cell1}=    Get Table Cell Element    ${muiResultTable}    0    1      
    Click        ${col0cell1}
    # Create a way to select first/last/some of the reservations
    Verify correct reservation is shown
    Verify Check in status is not shown when hovering on Guest name

Select Reservation with Check in Complete
    
    # Create a way to select first/last/some of the reservations
    Verify correct reservation is shown
    Verify Check in status is shown when hovering on Guest name

Go back to reservations
  Click ${reservations_menu_button}
  Verify button is shown with the highlight color
  Verify button has a checkmark # This seems to be the expected behaviour to keep the filter



Open Browser to Nelson Portal
    New Browser    ${browser}    ${headless}
    New Context
    New Page       ${MUI_URL}

Log in to Nelson Portal
    Type Secret    //*[@id='email']    $muiname
    Type Secret    //*[@id='password']    $muipass
    Click    //button[contains(text(),'Sign in')]

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
    IF     ${visibility} == 'visible'     # --> Toggle OFF
        Click    //div[contains(text(), '${filter}')]
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
        
    ELSE IF     ${visibility} == 'hidden'     # --> Toggle ON
        Click    //div[contains(text(), '${filter}')]
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
