*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.menu.resource
Resource          ${EXECDIR}/resources/keywords/mui.reservations.resource

*** Variables ***
${reports.types.button}    (//form//button[@class="dropbtn"])[1]
${reports.hotels.button}    (//form//button[@class="dropbtn"])[2]
*** Keywords ***

Select Environment   
    [Arguments]    ${environment}
    IF     '${environment}' == '${EMPTY}'
        ${e}=    Set Variable       Test (2) Omena
    ELSE IF     '${environment}' == 'test4'
        ${e}=    Set Variable       Test (2) Omena
    ELSE IF     '${environment}' == 'test3'
        ${e}=    Set Variable       Staging Omena
    ELSE IF     '${environment}' == 'test_salo'
        ${e}=    Set Variable       Test Salo
    ELSE IF     '${environment}' == 'ks_test'
        ${e}=    Set Variable       Test Kensington Stay      
    END
    Click     //b[contains(@class, "client-name-color") and contains(text(), "${e}")]

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

Verify Usage Page Elements
    Wait Until Visible        //div[@class='column-room']
    Verify Texts              Room Usages    Search by hotel     Edit Channels     ECI/LCO    Apply     Filter rooms     Show allotment

Verify Maintenance Page Elements
    Wait Until Visible   //button[contains(@routerlink, "/maintenance/create")]
    Click    //button[contains(@routerlink, "/maintenance/create")]

Verify Reports Page Elements
    Check URL Contains    reports
    Wait Until Visible                    ${reports.types.button}

