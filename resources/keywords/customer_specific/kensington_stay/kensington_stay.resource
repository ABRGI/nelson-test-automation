*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource


*** Keywords ***

Open New Browser To KS Home Page
    Open New Browser To URL   ${url.test.ks_home}    
    
Open Browser to Kensington Stay Home
    [Documentation]     A general startup keyword for opening a browser to the landing page.
    ...                 By default uses ${url} variable from environment variables, but can be overridden with an argument
    [Arguments]        ${url.test.ks_home}=${url}
    Open New Browser To URL    ${url.landing.page}
    #Set Viewport Size    1920    1080
    Allow Cookies 
    Set Environment 

Fill in TyL Details 
    Select Options By     id=brandTypeSelect    value     VISA
    Click and Fill        id=cardNumber        ${cc.tyl.visa}
    Click and Fill        id=cardholderName    ${cc.name}
    Select Options By     id=expiryMonth       value     01
    Select Options By     id=expiryYear        value     2024
    Click                 //input[@name="cardCode_masked"]
    Sleep     5s
    Type Secret           //input[@name="cardCode_masked"]    ${cc.tyl.code}
    Click                 id=nextBtn

Fill in Card Details
    Click and Fill       id=cc_name    Card Holder 
    Select Options By    id=cc_type    value     Visa
    Click and Fill       id=cc_number    4153013999700321
    Select Options By    id=cc_month    value     11
    Select Options By    id=ccYear    value     2023   
    Click and Fill       id=cc_cvc    321

Open Browser to Nelson Portal and Navigate to Test Exhibition
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Select Environment    Test Kensington