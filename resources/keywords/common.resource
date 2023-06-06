*** Settings ***
Documentation      A test suite for verifying modify booking functionality
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/EnvHandler.py
Library            Browser   
Library            OperatingSystem


*** Keywords ***

Click First Element Found
    [Arguments]    ${xpath}
    ${elements}    Get Elements          ${xpath}
    ${first_element}=    Set Variable    ${elements}[0]
    Click    ${first_element}


Create Email Address 
    ${inbox}    Create New Inbox        
    [Return]    ${inbox}

Wait For Confirmation Link
    [Arguments]     ${inbox_id}
    ${email}    Wait For Latest Email   ${inbox_id}
    ${link}     Extract Link            ${email.body}
    [Return]    ${link}

Read Email and Return Link
    ${inbox}=   Create Email Address 
    ${code}=    Wait For Confirmation Link      ${inbox.id}
    [Return]    ${link}


Open New Browser To URL
    [Arguments]    ${url}
    New Browser    ${browser}    ${headless}    timeout=${timeout}
    Set Browser Timeout    ${timeout}
    New Context 
    New Page       ${url}

Open Browser to Landing Page 
    [Documentation]     A general startup keyword for opening a browser to the landing page.
    New Browser    ${browser}    ${headless}    timeout=${timeout}
    Set Browser Timeout    ${timeout}
    New Context 
    New Page       ${url}
    #Set Viewport Size    1920    1080
        Wait Until Network Is Idle
    Get Title      contains     Cheap hotels in Helsinki
    Allow Cookies 

Open Browser Directly to Extras
    [Documentation]    This keyword is used only for debugging purposes if you want to use a quicker 
    ...                way to open the browser directly to the extras page.
    New Browser    ${browser}    ${headless}
    New Context 
    New Page       ${url}booking/#/order?hotelcode=HKI2&sdate=2023-05-05&edate=2023-05-07&adultCount=1&childCount=0&roomcount=1&vouchercode= 

Allow Cookies 
    [Documentation]    Allow Cookies/Toggle Cookie allowance
    #TBD: This should be conditional so it won't fail if not shown
    Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

Click and Fill
    [Documentation]     A keyword combination of Click and Fill Text since most of the form fields need a click
    [Arguments]    ${selector}    ${text}
    Click          ${selector}
    Fill Text      ${selector}    ${text}

Wait Until Visible 
    [Documentation]     An easier keyword for waiting until an element is visible
    [Arguments]    ${element}
    Wait For Elements State     ${element}        visible     timeout=${timeout}

