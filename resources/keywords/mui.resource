*** Settings ***
Documentation     A test suite for verifying modify booking functionality
Library           String
Resource          common.resource
Library           Browser

*** Keywords ***
Log in MUI
    ${name}    Get Environment Variable    ADMIN
    ${pass}    Get Environment Variable    ADPASS
    Type Secret    //*[@id='email']    $name
    Type Secret    //*[@id='password']    $pass

Log in MUI with Invalid Credentials
    Type Text    //*[@id='email']    hacker@gmail.com
    Type Text    //*[@id='password']    thispassissoinvalid
    Sleep    3s
    Click    //button[contains(text(),'Sign in')]
    ${shown}    Run Keyword And Return Status    Wait For Elements State    //div[@aria-label='Error!']    visible    timeout=3
    Run Keyword If    ${shown} == ${False}    Click    //button[contains(text(),'Sign in')]
    Verify Element Presence    //div[@aria-label='Error!']    ${True}
    Click    //button[@aria-label='Close']
    Sleep    2s

Log in MUI Successfully
    ${name}    Get Environment Variable    ADMIN
    ${pass}    Get Environment Variable    ADPASS
    Type Secret    //*[@id='email']    $name
    Type Secret    //*[@id='password']    $pass
    Click    //button[contains(text(),'Sign in')]
    Verify Element Presence    //div[@aria-label='Error!']    ${False}

Go to MUI
    [Arguments]    ${url}
    New Browser    ${browser}    ${headless}
    Set Browser Timeout    ${timeout}
    New Context
    New Page    ${url}
    Set Viewport Size    1600    900
    Wait Until Network Is Idle    timeout=5s

Open A MUI Client
    [Arguments]    ${client}
    Click    //b[normalize-space()='${client}']

New Reservation MUI
    Wait Until Network Is Idle    timeout=33s
    Click    //button[normalize-space()='New Reservation']

Create New Reservation MUI
    Wait Until Visible    //button[normalize-space()='Create']
    Wait Until Keyword Succeeds    10s    2s    Click    //button[normalize-space()='Create']

Select A Hotel
    [Arguments]    ${hotel}    ${MUI}=${False}
    Run Keyword If    '${MUI}'=='False'    Click    //button[normalize-space()='Choose hotel']
    Run Keyword And Ignore Error    Wait Until Network Is Idle    timeout=22s
    Run Keyword If    '${MUI}'=='False'    Wait Until Keyword Succeeds    10s    2s    Click    //a[@class='dropdown-item'][normalize-space()='${hotel}']
    Run Keyword If    '${MUI}'=='True'    Click    //button[normalize-space()='Choose your hotel']
    Sleep    2s
    Run Keyword If    '${MUI}'=='True'    Wait Until Keyword Succeeds    10s    2s    Click    //button/following-sibling::*//div[normalize-space()='${hotel}']

Log out of Nelson Portal
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Wait For Elements State    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img

Find Room
    Click    //button[normalize-space()='Find rooms']

Log out of Nelson In BUI Confirmation Page
    Click    //p[normalize-space()='Sign out']

Go to New Tab
    Switch Page    NEW
    Set Viewport Size    1400    800
    Run Keyword And Ignore Error    Wait Until Network Is Idle    timeout=22s

Given Admin creates a booking and completes payment
    Go to MUI    ${MUI-Link}
    Log in MUI with Invalid Credentials
    Log in MUI Successfully
    Open A MUI Client    Test (2) Omena
    New Reservation MUI
    Create New Reservation MUI
    Go to New Tab
    Select A Hotel    Turku, Humalistonkatu    ${True}
    Find Room
    Select Room and Extras
    Fill in Payment Details    env=mui

And Admin goes to page 3
    Verify Booking is Successful    ${False}

When Admin click on booker or guest name
    Click Booker or Guest Name    '${firstName}' '${lastName}'

Then button Save and Sign is shown
    Verify Save and Sign State    ${True}
    Close Edit Booker or Guest

And Admin Can Provides Info And Sign
    Sleep    3s
    Click    //button[normalize-space()='Check in']
    ${check}    Run Keyword And Return Status    Wait For Elements State    //input[@id='ssn']    visible    timeout=4
    Run Keyword If    ${check} == ${True}    Type Text    //input[@id='ssn']    ${ssn}
    Fill Default Guest Info
    Click Save and Sign
    User Draws Signature
    Close Signing Pad
    Sleep    2s
    Close Edit Booker or Guest
