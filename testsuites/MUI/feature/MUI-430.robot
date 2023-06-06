*** Settings ***
Documentation     This file contains test cases for testing MUI-430.robot
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
# When Sign in issue is resolved, uncomment the following line
# Suite Setup       Create Booking, Check in and get UUID
Library           Browser     auto_closing_level=SUITE
Suite Setup       Open Browser to Nelson Portal and Login
Suite Teardown    Close Browser

*** Test Cases ***

Filter Check in incomplete and open reservation
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled on
  Set Browser Timeout   15s
  Toggle Check in incomplete filter button
  Click Search Button
  Select Reservation with Check in Incomplete
  Go Back to Reservations
  Wait Until Network Is Idle

Remove filter and open a reservation
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled off
  Toggle Check in incomplete filter button
  Click Search Button
  Select Reservation with Check in Complete
