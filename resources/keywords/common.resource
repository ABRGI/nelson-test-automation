*** Settings ***

Library            Browser    auto_closing_level=SUITE

*** Keywords ***


Open Browser to Landing Page 
    New Browser    ${browser}    ${headless}
    New Context 
    New Page       ${url}
    Get Title      contains     Cheap hotels in Helsinki
    Set Browser Timeout     ${timeout}
    Allow Cookies 

Open Browser Directly to Extras
    [Documentation]    For Debugging purposes
    New Browser    ${browser}    ${headless}
    New Context 
    New Page       http://test4.omenahotels.com/en/booking/#/order?hotelcode=HKI2&sdate=2023-05-05&edate=2023-05-07&adultCount=1&childCount=0&roomcount=1&vouchercode= 

Allow Cookies 
    #TBD: This should be conditional so it won't fail if not shown
    Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

Click and Fill
    [Arguments]    ${selector}    ${text}
    Click          ${selector}
    Fill Text      ${selector}    ${text}

Wait Until Visible 
    [Arguments]    ${element}
    Wait For Elements State     ${element}        visible     timeout=${timeout}
