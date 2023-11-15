*** Settings ***
Documentation     This file contains smoke tests for MUI
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Suite Teardown    Close Browser
Force Tags        smoke    prod    regression

*** Variables ***
${reports.button.types}    (//form//button[@class="dropbtn"])[1]
${reports.button.hotels}    (//form//button[@class="dropbtn"])[2]
${reports.button.week}    //button[contains(text(), 'Last Week')]
${reports.button.month}    //button[contains(text(), 'Last Week')]
${reports.button.startofmonth}    //button[contains(text(), 'Last Week')]
${reports.button.startofyear}    //button[contains(text(), 'Last Week')]
${reports.button.download}    //button[contains(text(), 'Download Report')]
${reports.button.inhouse}    //button[contains(text(), 'Guests In-House')]
*** Test Cases ***


Log in with correct Username and Password
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Verify Dashboard Elements
    Select Environment   ${ENV}
    Verify Reservations Page Grid Elements
    Verify Hotels in Search By Hotel Dropdown 
    Click Datepicker Start
    Click Datepicker End
    Click Clear Search

Open Reports Page and Verify
    Click Reports from Navigation Menu
    Verify Reports Page Elements

Verify Each Report Can be Downloaded
    Click    ${reports.button.types}
    ${report.items}=     Get Elements    //div[contains(@class, 'dropdown-content')]/ul/child::node()
    FOR     ${report}    IN    @{report.items}
        Click    ${reports.button.week}
        Click    ${reports.button.types}
        ${report.name}=         Get Property    ${report}    innerText
        Wait For Elements State    ${reports.button.download}    enabled
        ${promise}             Promise To Wait For Download    ${EXECDIR}/resources/downloads/${report.name}.csv
        Click                  ${reports.button.download} 
        ${file_obj}=           Wait For  ${promise}
        File Should Exist      ${file_obj}[saveAs]
    END

Verify Usage Page
   Click Usage from Navigation Menu
   Verify Usage Page Elements

Verify Maintenance Page
    Click Maintenance from Navigation Menu
    Verify Maintenance Page Elements

Verify Customers Page
    Click Customers from Navigation Menu

Verify Pricing Page
    Click Pricing from Navigation Menu

Verify Allotments Page
    Click Allotments from Navigation Menu

Verify Vouchers Page
    Click Voucher from Navigation Menu

Verify Breakfast Page
    Click Breakfast from Navigation Menu

Verify Settings Page
    Click Settings from Navigation Menu

Verify Locks Page
    Click Locks from Navigation Menu

Log Out 
    Click      //div[contains(@class, 'mobile-hide')]//img[@src='assets/images/icon-signout.svg']

Try Logging in without Password
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    admin    ${EMPTY}
    Close Browser

Try Logging in without Username
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    ${EMPTY}    pass
    Close Browser

Try Logging in with incorrect Password/Username combination
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    admin    admin
    Close Browser