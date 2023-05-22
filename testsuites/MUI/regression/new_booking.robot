*** Settings ***
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Library           Browser    auto_closing_level=SUITE
Resource          ${EXECDIR}/resources/keywords/mui.resource

## Why are these imported again?
## Also, imports should be done by not using a relative path but the execution directory
Resource          ../resources/keywords/booking.resource
Resource          ../resources/keywords/common.resource
Resource          ../resources/keywords/mui.resource

### 1. This test case is not understandable for business/non-tech people
### Try to find a bettern name for the test case and use better wording for keywords
### It should look like a test case - use the Gherkin syntax or similar

### 2. There are no further verifications done for any inputs. Create another test case
### that does verifications for all inputs - there should always be a verification for "false" inputs as well

### 3. If you use imported resources like here mui.resource, you should not use the resource prefix - it 
### is not understandable for non-tech people

### 4. Is it necessary to have two "Select Hotel" keywords? One should be enough to be used for both MUI and BUI 

### 5. Teardown could be added to the settings - this will help the readability for the non-tech people.

### 6. In the end, check all phrasing in AI 

*** Test Cases ***
Admin Create A Booking
    Open Nelson Portal    ${MUI-Link}     # Variable should not be shown here
    Log in MUI
    Open A MUI Client    Test (2) Omena
    New Reservation MUI
    Create New Reservation MUI
    Switch Page    NEW
    mui.Select Hotel    Turku, Humalistonkatu
    Find Room
    Select Room and Extras
    Fill in Payment Details    mui
    Verify Booking is Successful
    Click Booker or Guest Name    '${firstName}' '${lastName}'
    Verify Save and Sign State    ${False}
    Close Edit Booker or Guest
    [Teardown]    Run Keyword And Ignore Error    Log out of Nelson In BUI Confirmation Page
