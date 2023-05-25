*** Settings ***
Documentation     A test suite for verifying modify booking functionality
Library           ${EXECDIR}/resources/libraries/Gmail.py
Library           ${EXECDIR}/resources/libraries/Helpers.py
Library           Browser
Library           ${EXECDIR}/resources/libraries/EnvHandler.py
Library           Browser

*** Keywords ***
Get Link from Email
    ${link}=    Gmail.Get Link
    [Return]    ${link}

Open Browser to Landing Page
    [Documentation]    A general startup keyword for opening a browser to the landing page.
    New Browser    ${browser}    ${headless}    timeout=${timeout}
    Set Browser Timeout    ${timeout}
    New Context
    New Page    ${url}
    Set Viewport Size    1920    1080
    Wait Until Network Is Idle
    Get Title    contains    Cheap hotels in Helsinki
    Allow Cookies
    Wait Until Keyword Succeeds    10s    2s    Click    //ul[contains(@class, 'collapse')]//a[normalize-space()='Book now']

Select Hotel
    [Arguments]    ${hotel}
    Click    //button[normalize-space()='Choose your hotel']
    Wait Until Keyword Succeeds    10s    2s    Click    //div[contains(text(),'${hotel}')]
    Click    //button[normalize-space()='Find rooms']

Open Browser Directly to Extras
    [Documentation]    This keyword is used only for debugging purposes if you want to use a quicker
    ...    way to open the browser directly to the extras page.
    New Browser    ${browser}    ${headless}
    New Context
    New Page    ${url}booking/#/order?hotelcode=HKI2&sdate=2023-05-05&edate=2023-05-07&adultCount=1&childCount=0&roomcount=1&vouchercode=

Allow Cookies
    [Documentation]    Allow Cookies/Toggle Cookie allowance
    ${check}    Run Keyword And Return Status    Wait For Elements State    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll    visible    timeout=6
    Run Keyword If    ${check} == ${True}    Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

Click and Fill
    [Arguments]    ${selector}    ${text}
    [Documentation]    A keyword combination of Click and Fill Text since most of the form fields need a click
    Click    ${selector}
    Fill Text    ${selector}    ${text}

Wait Until Visible
    [Arguments]    ${element}
    [Documentation]    An easier keyword for waiting until an element is visible
    Wait For Elements State    ${element}    visible    timeout=${timeout}

Verify Element Presence
    [Arguments]    ${path}    ${shown}
    ${check}    Run Keyword And Return Status    Wait For Elements State    ${path}    visible    timeout=6
    Run Keyword If    ${shown} == ${true}    Should Be True    ${check}==${True}
    Run Keyword If    ${shown} == ${false}    Should Be True    ${check}==${False}

Check Element Presence
    [Arguments]    ${path}
    ${check}    Run Keyword And Return Status    Get Element    ${path}
    [Return]    ${check}
