*** Settings ***
Library            ${EXECDIR}/resources/libraries/Helpers.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A Draft Test Suite for BUI Sec Tests
Suite Setup        Open Browser to Landing Page 
Force Tags         smoke    tbd
*** Test Cases ***

Verify Harmful Text Injection in Login
    Pass Execution    TBD

Verify Successful Login
    [Documentation]    Verify that a user can login successfully
    Pass Execution   TBD

Verify Invalid Login    
    [Documentation]    Verify that a user cannot login with invalid credentials
    Pass Execution    TBD

Verify Menu before Login 
    [Documentation]    Verify that the menu is not displayed before a successful login
    Pass Execution    TBD

Verify Menu after Login
    [Documentation]    Verify that the menu is displayed after a successful login
    Pass Execution    TBD

Verify Logout
    [Documentation]    Verify that a user can logout successfully
    Pass Execution    TBD

Verify Forgot Password
    [Documentation]    Verify that a user can reset their password
    Pass Execution    TBD
