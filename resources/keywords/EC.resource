*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui_menu.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource

*** Variables ***

${BDCNo}     547370586    #Default for debug, is overridden in full test suite run
${BDCHotelId}    10304890

*** Keywords ***

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
    Select Environment    Test Exhibition