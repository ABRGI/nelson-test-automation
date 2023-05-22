*** Settings ***
Documentation     A test suite for verifying modify booking functionality
Library           String
Resource          common.resource
Library           OperatingSystem

*** Keywords ***
Log in MUI
    ${name}    Get Environment Variable    ADMIN
    ${pass}    Get Environment Variable    ADPASS
    Type Secret    //*[@id='email']    $name
    Type Secret    //*[@id='password']    $pass
    Click    //button[contains(text(),'Sign in')]

Open Nelson Portal
    [Arguments]    ${url}
    New Browser    ${browser}    ${headless}
    Set Browser Timeout    ${timeout}
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
    Set Viewport Size    1920    1080
    Run Keyword And Ignore Error    Wait Until Network Is Idle    timeout=22s
