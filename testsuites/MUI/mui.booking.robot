*** Settings ***

#Suite Setup         Open Browser to Nelson Portal and Login
Suite Teardown    Close Browser
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Resource           ${EXECDIR}/resources/keywords/mui.resource
Documentation      A test suite for verifying modify booking functionality
Force Tags         smoke    regression

*** Test Cases ***    

Open Browser to Nelson Portal and Login
    Open Browser to Nelson Portal
    Log in to Nelson Portal
    Select Environment    ${ENV}