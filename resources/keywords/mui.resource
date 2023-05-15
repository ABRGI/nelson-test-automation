*** Settings ***
Documentation      A test suite for verifying modify booking functionality

Library           String

*** Keywords ***
Log in MUI
    Type Text    //*[@id='email']    tdlong@tma.com.vn
    Type Text    //*[@id='password']    PtFx5P#M67UV
	Click    //button[contains(text(),'Sign in')]

Open Nelson Portal
    [Arguments]    ${url}
    New Browser    ${browser}    ${headless}
    New Context
    New Page    ${url}
	
Open A MUI Client
    [Arguments]    ${client}
    Click    //b[normalize-space()='${client}']

New Reservation MUI
    Click    //button[normalize-space()='New Reservation']

Create New Reservation MUI
    Wait Until Visible    //button[normalize-space()='Create']
    Wait Until Keyword Succeeds    10s    2s    Click    //button[normalize-space()='Create']

Select Hotel
    [Arguments]    ${hotel}
    Click    //button[normalize-space()='Choose your hotel']
    Wait Until Keyword Succeeds	10s	2s    Click    //div[contains(text(),'${hotel}')]

Log out of Nelson Portal
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Wait For Elements State    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img
    Click    //div[contains(@class,'mobile-hide')]//button[contains(text(),'Sign out')]/img

Find Room
    Click    //button[normalize-space()='Find rooms']

Log out of Nelson In BUI Confirmation Page
    Click    //p[normalize-space()='Sign out']