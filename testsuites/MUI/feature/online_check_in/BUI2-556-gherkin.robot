*** Settings ***
Suite Setup       Open Browser to Landing Page
Suite Teardown    Close Browser
Library           Browser
Resource          ${EXECDIR}/resources/keywords/common.resource
Resource          ${EXECDIR}/resources/keywords/booking.resource
Resource          ${EXECDIR}/resources/keywords/mui.resource
Force Tags        skip     # skip tag is used as no keywords are yet implemented

*** Keywords ***

Select Hotel Turku, Humalistonkatu 
    booking.Select Hotel    Turku, Humalistonkatu
    # Verify that the hotel is selected and not something else

Select Dates and Guests
    booking.Choose Dates and Guests
    # Verify dates are selected and guests are added

Select a Standard Room
    # Verify standard is selected
    # Verify only one room is selected 

*** Test Cases ***

Make a Booking - Basic use case
    Select Hotel Turku, Humalistonkatu 
    Select Dates and Guests
    Select a Standard Room
    Click Continue to Extras Button 
    Verify Join for free is selected 
    Accept offers and Terms
    Fill in Contact Information and Password 
    Select Web Bank, Nordea as Payment Method
    Complete Payment
    Verify Payment was successful window is displayed
    Click Ok Button 
    
    

    And I choose the dates and number of guests for the booking
    And I select the room and any desired extras
    And I proceed to the payment stage
    Then I check that the regular rate is correctly displayed
    And I check the option to join as a member
    And I check again that the regular rate is correctly displayed
    And I fill out my contact information
    And I accept the terms and proceed to payment
    And I quickly complete the payment process
    Then I should verify that the booking was successful and receive a code

Verify UI when users have not signed
    Given the primary banner is configurable
    And the notification of the room number and door code is not active
    And the guest list is visible
    And the booking summary is displayed
    And the "My bookings" link is visible
    And the secondary banner is configurable
    Then the sticky Call To Action (CTA) should be visible

Verify UI when users have signed
    Given the primary banner is configurable
    And the notification of the room number and door code is active
    And the guest list is visible
    And the booking summary is displayed
    And the "My bookings" link is visible
    And the secondary banner is configurable
    Then the sticky Call To Action (CTA) should be visible
In this reformatted version, the Given keyword establishes the initial context for each scenario, the When keyword describes actions that change that context, and the Then keyword verifies that the actions have had the expected result. This allows anyone reading the test case to understand the expected behavior of the system, even if they don't know how to code.






Regenerate response
Make a booking
    Select Hotel    Turku, Humalistonkatu
    Find Room
    Choose Dates and Guests
    Select Room and Extras
    Continue to Payment
    Check Regular Rate
    Check Join as Member
    Check Regular Rate
    Fill Contact Info
    Accept Term and Proceed to Payment
    Quickly Pay
    ${code}    Verify Successful Booking

Verify UI when users have not signed
    Configurable primary banner
    Check Notification of the room number and door code    ${False}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA

Verify UI when users have signed
    Configurable primary banner
    Check Notification of the room number and door code    ${True}
    Guest list
    Booking summary
    My bookings link
    Configurable secondary banner
    Check the sticky CTA
