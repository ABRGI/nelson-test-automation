*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource

*** Keywords ***


Verify Reservation Page Elements
    [Documentation]    Verifies the texts on a single reservation page
    Verify Texts    Contact person     Comments     Payments     Door Code     Refund     Change reservation     View guests     Add payment  Product     Price    Non-refundable    SSN   

Click New Reservation Button 
    Click     //button[contains(text(), 'New Reservation')]

Verify Reservations Page Grid Elements
    [Documentation]        Verifies the elements on the reservations grid
    Wait Until Visible    //input[contains(@class, 'searchQuery')]

Select Normal Reservation 
    Click       (//input[@name='type-selection'])[1]
    Click       //button[contains(text(),'Create')]

Select Group Reservation
    Click       (//input[@name='type-selection'])[2]
    Click       //button[contains(text(),'Create')]

Click First Search Result Row 
    Click     (//tr)[1]

Click Search Button  
    Wait Until Network Is Idle
    Click      //button[contains(text(), 'Search')]
    Wait Until Network Is Idle
    Wait Until Visible    //th[contains(@class, 'sortActive')]

Search with String
    [Arguments]    ${searchText}
    Click         //input[contains(@class, "searchQuery")]
    Fill Text    //input[contains(@class, "searchQuery")]     ${searchText}
    Click Search Button

Click Search By Hotel Dropdown 
    Click     //label[contains(text(), "by hotel")]/following-sibling::button

Click Search By Channel Dropdown
    Click     //label[contains(text(), "channel")]/following-sibling::button

Click Datepicker Start 
    Click    (//button[contains(@class, "datepicker")])[1]

Click Datepicker End 
    Click    (//button[contains(@class, "datepicker")])[2]

Select Hotel for Search 
    [Arguments]    ${hotel}=HKI2
    IF     '${environment}' == 'ks_test'
        Log To Console    No Hotel Selection
    ELSE
        Sleep    3s
        Click Search By Hotel Dropdown 
        Sleep    3s
        Click     //li[contains(text(), '${hotel}')]
    END

Verify Hotels in Search By Hotel Dropdown
    [Documentation]    Verifies the hotels in the search by hotel dropdown
    IF     '${environment}' == 'ks_test'
        Log To Console    No Hotel Selection for Kensington Stay
    ELSE IF    '${environment}' == 'test4'
        Sleep    3s
        Click Search By Hotel Dropdown 
        Sleep    3s
        ${hotels}=    Get Elements    //div[contains(@class, "dropdown-content")]/ul/li
        ${hotelsCount}=    Get Length    ${hotels}
        Should Be Equal As Integers    ${hotelsCount}    9
    END

Verify Channels in Search By Channel Dropdown
    [Documentation]    Verifies the channels in the search by channel dropdown
    Sleep    3s
    Click Search By Channel Dropdown 
    Sleep    3s
    ${channels}=    Get Elements    //div[contains(@class, "dropdown-content")]
    ${channelsCount}=    Get Length    ${channels}
    Log To Console    Channels found:     ${channelsCount}
    Should Be Equal As Integers    ${channelsCount}    6


Select Booking Channel for Search 
    [Arguments]    ${bookingChannel}=Booking.com
    
Toggle by Stay 
    [Arguments]        ${stay}=Arriving Today
    [Documentation]   This keyword toggles the filter on or off and verifies the icon is showing or not showing
    Click            //button[contains(text(), '${stay}')]
    Wait Until Network Is Idle

Toggle Arriving Today
    Toggle by Stay    Arriving Today

Toggle Staying Tonight
    Toggle by Stay    Staying tonight

Toggle Departing Today 
    Toggle by Stay    Departing today

Click Clear Search 
    Click     //button[contains(text(), 'Clear search')]
    Wait Until Network Is Idle

Toggle Check in incomplete filter button
   Wait Until Keyword Succeeds    10s    2s    Toggle Filter    incomplete

Select First Guest Info Table
    ${table}=   Get Element     (//table[contains(@class, 'custom-table')])[3]
    [Return]    ${table}

Get Icon Visibility
    [Arguments]    ${filter}
    Get Element     //div[contains(text(), '${filter}')]
    ${result}=   Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    [Return]    ${result}

Toggle Filter
    [Arguments]    ${filter}=incomplete    
    [Documentation]    This keyword toggles the filter on or off and verifies the icon is showing or not showing
    ...                By giving the filter an argument, it can be used to all filters on the page.
    ${visibility}=   Get Icon Visibility    ${filter}
    IF     "${filter}" == 'incomplete'
        Click    (//div[@class="filter-radio"])[5]
        Check button design    ${filter}    ${visibility}
    ELSE     
        Pass Execution     TBD
    END 

Check button design
    [Arguments]        ${filter}    ${visibility}
    IF     "${visibility}" == 'visible'     # --> Toggle OFF
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden

    ELSE IF     "${visibility}" == 'hidden'     # --> Toggle ON
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
    END

Select First Found Reservation
    [Documentation]    This keyword selects the first reservation n
    ${col0cell1}=    Get Table Cell Element    ${muiResultTable}    0    1      
    Click        ${col0cell1}
    Wait Until Network Is Idle
    Verify Reservation Page Elements


Assert Reservationd View is Open 
    [Arguments]    ${filter}
    ${visibility}  Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    Get Element     //div[contains(text(), '${filter}')]
    ${result}=   Get Element States    //div[contains(text(), '${filter}')]    then    value & (visible | hidden)
    IF     ${visibility} == 'visible'     # --> Toggle OFF
        Click    //div[contains(text(), '${filter}')]
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
        
    ELSE IF     ${visibility} == 'hidden'     # --> Toggle ON
        Click    //div[contains(text(), '${filter}')]
        ${visibility}=   Get Icon Visibility    ${filter}
        Should Be Equal As Strings    ${visibility}    hidden
    END