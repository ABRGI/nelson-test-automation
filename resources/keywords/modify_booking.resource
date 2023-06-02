*** Settings ***
Documentation     This file contains keywords that are related to the booking process.
Library           ${EXECDIR}/resources/libraries/Helpers.py
Resource          ${EXECDIR}/resources/variables/variables.resource
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/variables/locators.resource
Library           Browser    auto_closing_level=SUITE
Library           String

*** Keywords ***

Login as Member
    [Arguments]    ${username}=    ${password}=
