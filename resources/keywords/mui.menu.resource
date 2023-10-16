*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource

*** Keywords ***

# TODO: Add verifications after each click 

Select From Menu
    [Arguments]    ${item}
    Wait Until Network Is Idle
    TRY
        Click     //a[@href='#/${item}' and contains(@class, 'capitalize') and (not(contains(@class,'capitalize-mobile')))]
    EXCEPT
        Log To Console    ${item} is not found in the menu
    END

Click Reservations from Navigation Menu
    Select From Menu   reservations     

Click Usage from Navigation Menu
    Select From Menu   usage 

Click Maintenance from Navigation Menu
    Select From Menu   maintenance 

Click Reports from Navigation Menu
    Select From Menu   reports 

Click Customers from Navigation Menu
    Select From Menu   customers 

Click Pricing from Navigation Menu
    Select From Menu   pricing 

Click Allotments from Navigation Menu
    Select From Menu   allotments 

Click Voucher from Navigation Menu
    Select From Menu   voucher 

Click Breakfast from Navigation Menu
    Select From Menu   breakfast 

Click Settings from Navigation Menu
    Select From Menu   hotels 

Click Locks from Navigation Menu
    Select From Menu   locks 

Click Back to Admin from Navigation Menu
    Click     (//button[contains(@class, "btn-back-admin")])[0]