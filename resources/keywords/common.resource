*** Settings ***
Documentation      A test suite for verifying modify booking functionality
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Library            Browser   
Library            OperatingSystem
Library            String
Library            Process

*** Keywords ***

Is Element Visible
    [Arguments]  ${selector}
    ${isVisible}=     Get Element States    ${selector}    then    bool(value & visible) 
    [Return]    ${isVisible}

Create Email and Return Inbox
    [Documentation]    Creates a new email address and returns the inbox object
    ${inbox}=   Create new Inbox
    [Return]    ${inbox}

Wait For Confirmation Link
    [Arguments]     ${inbox_id}
    ${email}    Wait For Latest Booking Confirmation   ${inbox_id}
    ${link}     Extract Link            ${email.body}
    [Return]    ${link}

Read Email and Return Link
    [Arguments]     ${inbox}
    ${link}=    Wait For Confirmation Link      ${inbox.id}
    [Return]    ${link}

Is Element Found
    [Arguments]  ${selector}
    [Documentation]    A keyword that has a very complex way of figuring out whether an
    ...                element is found or not because I had trouble with the built-in keywords
    ...                Can be solved differently if you have a better idea
    Set Browser Timeout     10s
    TRY
        ${els}=     Get Elements     ${selector}    
        ${count}=  Get Length  ${els}
        IF     ${count} > 0
            ${visible}  Set Variable    True
        ELSE 
            ${visible}  Set Variable    False
        END
        
    EXCEPT 
        ${visible}  Set Variable    False
    END
    Set Browser Timeout     ${timeout}
    [Return]  ${visible}

Click First Element Found
    [Arguments]    ${xpath}
    ${elements}    Get Elements          ${xpath}
    ${first_element}=    Set Variable    ${elements}[0]
    Click    ${first_element}

Should Be Visible
    [Arguments]  ${selector}
    ${isVisible}=     Get Element States    ${selector}    then    bool(value & visible) 
    [Return]    ${isVisible}

Verify Texts
    [Arguments]  @{listOfStrings}
    [Documentation]    Verifies that the given texts are visible on the page, Browser Timeout
    ...                is set to 8 seconds to speed up the test
    ...                Takes a list of strings as an argument
    Set Browser Timeout     8s
    FOR  ${text}  IN  @{listOfStrings}
        ${elements}=  Get Elements  text=${text}
        ${element_visible}=  Run Keyword And Return Status  Should Be Visible  ${elements}[0]
        Should Be True  ${element_visible}  The element containing text '${text}' should be visible but it is not.
    END
    Set Browser Timeout     ${timeout}

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
    Wait Until Network Is Idle       
    #Set Viewport Size    1920    1080
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

Is Force Signature Enabled
    [Documentation]    Checks if the force signature is on or off
    # TODO: Modify this to be a common method to check _any_ value of the config
    # TODO: Modify feature-config url to depend on environment
    ${output}    Run Process    curl    https://test4.omenahotels.com/feature-config.json
    ${forceSSN}    Get Line    ${output.stdout}    8
    ${forceSignature}    Get Line    ${output.stdout}    9
    ${guestSignature}    Get Line    ${output.stdout}    10
    ${forceSSN}    Remove String    ${forceSSN}    "forceSSN":    ,    ${SPACE}
    ${forceSignature}    Remove String    ${forceSignature}    "forceSignature":    ,    ${SPACE}
    ${guestSignature}    Remove String    ${guestSignature}    "guestSignature":    ,    ${SPACE}
    Run Keyword If    '${forceSignature}' == 'true'    Log    Forcing signature on => call Click Save and Sign
    Run Keyword If    '${forceSignature}' == 'false'    Log    Forcing signature off => call Click Save
    [Return]    ${forceSignature}

