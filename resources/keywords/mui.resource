*** Settings ***
Documentation     A test suite for verifying modify booking functionality
Library           String
Library    Browser
Resource    common.resource

*** Keywords ***
Log in MUI Fail
    Type Text    //*[@id='email']    hacker@gmail.com
    Type Text    //*[@id='password']    iamsohandsome
    Click    //button[contains(text(),'Sign in')]
    Verify Element Presence    //div[@aria-label='Error!']    ${True}
    Click    //button[@aria-label='Close']
Log in MUI Successful
    Clear Text     //*[@id='email']
    Clear Text     //*[@id='password'] 
    Sleep    5s
    Type Text    //*[@id='email']    tdlong@tma.com.vn
    Type Text    //*[@id='password']    PtFx5P#M67UV
    Click    //button[contains(text(),'Sign in')]
    Verify Element Presence    //div[@aria-label='Error!']    ${False}
Go to MUI
    [Arguments]    ${url}    
    New Browser    ${browser}    ${headless}
    New Context
    New Page    ${url}
    Set Viewport Size    1920    1080

Open A MUI Client
    [Arguments]    ${client}
    Click    //b[normalize-space()='${client}']

New Reservation MUI
    Wait Until Network Is Idle    timeout=33s
    Click    //button[normalize-space()='New Reservation']

Create New Reservation MUI
    Wait Until Visible    //button[normalize-space()='Create']
    Wait Until Keyword Succeeds    10s    2s    Click    //button[normalize-space()='Create']

Select Hotel
    [Arguments]    ${hotel}
    Click    //button[normalize-space()='Choose your hotel']
    Wait Until Keyword Succeeds    10s    2s    Click    //div[contains(text(),'${hotel}')]

Log out of Nelson Portal
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Wait For Elements State    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img

Find Room
    Click    //button[normalize-space()='Find rooms']

Log out of Nelson In BUI Confirmation Page
    Click    //p[normalize-space()='Sign out']

Go to New tab
    Switch Page    NEW
