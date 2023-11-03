*** Settings ***

Suite Setup         Open Browser to Nelson Portal and Login
Suite Teardown      Close Browser
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Resource           ${EXECDIR}/resources/keywords/mui.resource
Documentation      A test suite for verifying GBE2 in MUI
Force Tags         smoke    regression

*** Test Cases ***    

Create New Group Booking
    Start New Reservation Flow in MUI    Group