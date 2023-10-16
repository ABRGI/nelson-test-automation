*** Settings ***
Documentation      A common resource file for all keyword and test case files 
Library            ${EXECDIR}/resources/libraries/Helpers.py
Library            ${EXECDIR}/resources/libraries/MailSlurp.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Library            Browser    auto_closing_level=SUITE
Library            OperatingSystem
Library            String
Library            Process
Library            RequestsLibrary

*** Keywords ***

Take Custom Screenshot
    [Documentation]    Sets the screenshot directory and filename
    Pass Execution     TBD

Check If String Contains
    [Arguments]    ${string}    ${substring}
    ${contains}=    Check If String Contains Substring    ${string}    ${substring}
    [Return]    ${contains}

Set Environment
    [Documentation]    A keyword that gets the environment from URL and checks it is the same as variable
    ${currentUrl}=     Get Url
    ${env}=        Get Environment From Url    ${currentUrl}
    Should Be Equal As Strings    ${env}    ${environment}

Get BUI Status
    [Documentation]    Get the status of the microservice - running on Softico
    [Arguments]    ${env_name}=test4
    Create Session    frends    ${microservice_url}
    ${response}=    GET On Session    frends    /status/${env_name}
    [Return]    ${response.json()}

Check URL Contains
    [Arguments]    ${expected_string}
    Set Browser Timeout     3s
    ${current_url}=    Get URL      
    IF    '${expected_string}' in '${current_url}'    
        Log    URL contains the expected string: ${expected_string}
        ${urlContains}      Set Variable    True
    ELSE    
        Log    URL does not contain the expected string: ${expected_string}
        ${urlContains}      Set Variable    False
    END
    Set Browser Timeout     ${timeout}
    [Return]    ${urlContains}

Is Element Visible
    [Arguments]  ${selector}
    ${isVisible}=     Get Element States    ${selector}    then    bool(value & visible) 
    [Return]    ${isVisible}

Get Inbox ID
    Log To Console      Mailslurp: ${inbox_id}
    [Return]    ${inbox_id}

Create Email and Return Inbox
    [Documentation]    Creates a new email address and returns the inbox object
    ${inbox}=   Create new Inbox
    #${inbox}=   Get Inbox      ${inbox_id}
    Log To Console    ${inbox.id}
    [Return]    ${inbox}

Wait For Confirmation Link
    [Arguments]     ${inbox_id}
    [Documentation]    Waits for latest Booking Confirmation and extracts the link from email
    ${email}    Wait For Latest Booking Confirmation   ${inbox_id}
    ${link}     Extract Link            ${email.body}
    [Return]    ${link}

Read Email and Return Link
    [Arguments]     ${inbox}
    [Documentation]    Waits for latest Booking Confirmation and extracts the link from email
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
    New Browser    ${browser}    ${headless}    timeout=${timeout}     downloadsPath=${EXECDIR}/resources/downloads
    Set Browser Timeout    ${timeout}
    New Context     acceptDownloads=True   
    New Page       ${url}

Open Browser to Landing Page 
    [Documentation]     A general startup keyword for opening a browser to the landing page.
    Log To Console     Environment: ${environment}
    IF     '${environment}' == 'test3'
                Set Suite Variable   ${url.landing.page}     https://test3.omenahotels.com/en
    ELSE IF     '${environment}' == 'ks_test'
                Set Suite Variable   ${url.landing.page}     https://test.kensingtonstay.com/en
    ELSE IF     '${environment}' == 'salo_test'
                Set Suite Variable   ${url.landing.page}      https://test.kensingtonstay.com/en
    ELSE IF    '${environment}' == 'test4'
                Set Suite Variable   ${url.landing.page}     https://test4.omenahotels.com/en
    END
    Open New Browser To URL    ${url.landing.page}
    #Set Viewport Size    1920    1080
    Allow Cookies 
    Set Environment 

Open Browser Directly to Extras
    [Documentation]    This keyword is used only for debugging purposes if you want to use a quicker 
    ...                way to open the browser directly to the extras page.
    New Browser    ${browser}    ${headless}
    New Context 
    New Page       ${url}booking/#/order?hotelcode=HKI2&sdate=2023-05-05&edate=2023-05-07&adultCount=1&childCount=0&roomcount=1&vouchercode= 

Allow Cookies 
    [Documentation]    Allow Cookies/Toggle Cookie allowance
    ${cookieModalVisible} =     Is Element Found        id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    IF     ${cookieModalVisible}
        Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Log     No Cookie Modal Visible
    END

Click and Fill
    [Documentation]     A keyword combination of Click and Fill Text since most of the form fields need a click
    [Arguments]    ${selector}    ${text}
    Click          ${selector}
    Fill Text      ${selector}    ${text}


Click and Fill with Sleep
    [Documentation]     A keyword combination of Click and Fill, for too quick runs, added 1s sleep after input
    [Arguments]    ${selector}    ${text}
    Click and Fill    ${selector}    ${text}
    Sleep         1s        BDC is weird with these fields

Wait Until Visible 
    [Documentation]     An easier keyword for waiting until an element is visible
    [Arguments]    ${element}
    Wait For Elements State     ${element}        visible     timeout=${timeout}

Is Item Enabled
    [Documentation]    Checks if an item is true/false in config, by default checks for forceSSN
    [Arguments]    ${item}=forceSSN
    ${isItem}=     Get Config Item    ${url}     ${item}
    [Return]    ${isItem}

Is Force Signature Enabled
    # Use "Is Item Enabled" instead, this is deprecated and only works for test4
    [Documentation]    Should no longer be used, use Is Item Enabled instead
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

Get State    
    [Arguments]    ${element}
    ${state}=     Get Element States    ${element}    validate    value
    [Return]    ${state}