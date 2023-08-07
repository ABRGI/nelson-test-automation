*** Settings ***
Documentation     This file contains smoke tests for MUI
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Library           Browser     auto_closing_level=SUITE
Suite Teardown    Close Browser

*** Test Cases ***

Try Logging in without Password
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    admin    ${EMPTY}

Try Logging in without Username
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    ${EMPTY}    pass

Try Logging in with incorrect Password/Username combination
    Open Browser to Nelson Portal
    Log in to Nelson Portal with Credentials    admin    admin

Log in with correct Username and Password
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Verify Dashboard Elements
    Select Environment   ${ENVIRONMENT}

Verify Users Page
    Click     //a[contains(@href, "users") and (@class="capitalize")]

Verify User Profile
    Click     (//span[contains(@class, "avatar")])[0]

Log Out 
    Click  (//img[contains(@src, "signout")][0]