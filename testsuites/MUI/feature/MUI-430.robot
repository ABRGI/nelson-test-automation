*** Settings ***
Documentation     This file contains test cases for testing MUI-430.robot
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
# TODO: Debug and uncomment Suite Setup       Create Booking, Check in and get UUID
Library           Browser     auto_closing_level=SUITE
Suite Teardown    Close Browser

*** Test Cases ***

Filter all reservations with Check-in incomplete
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled on
  Open Browser to Nelson Portal and Login
  Set Browser Timeout   15s
  Select Hotel for Search    hotel=HKI2
  Toggle Check in incomplete filter button
  Click Search Button
  Select Reservation with Check in Incomplete
  Click Reservations from Navigation Menu

Remove filter and find a reservation with Check-in complete
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled off
  Open Browser to Nelson Portal and Login
  Select Hotel for Search    hotel=HKI2
  Click Search Button
  Select Reservation with Check in Complete
