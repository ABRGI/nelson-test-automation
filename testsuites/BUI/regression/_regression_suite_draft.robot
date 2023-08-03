*** Settings ***
Library            ${EXECDIR}/resources/libraries/Helpers.py
Resource           ${EXECDIR}/resources/variables/variables.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Documentation      A Draft Test Suite for BUI Regression Tests
Suite Setup        Open Browser to Landing Page 

*** Test Cases ***

Verify Booking Process Step 1 Forms and Pages
    [Documentation]    Verify that the booking process pages are displayed correctly
    Pass Execution    TBD
    # Verify Booking Language
    # Verify Icons and Texts
    # Verify Dropdown Contents
    # Verify Calendar Defaults to Today
    # Verify Calendar Content

Verify Booking Process Step 2 Forms and Pages  
    [Documentation]    Verify that the booking process pages are displayed correctly
    Pass Execution    TBD  
    # Verify Guests Dropdown
    # Verify Rooms Dropdown
    # Verify Past Date reservations are not possible
    # Verify the reservation does not exceed 7 rooms.
    # Verification does not allow bookings room dates in the past (Calendar select at past dates is disabled.)
    # Verify that the "Choose your Hotel" drop-down work correct with the specifications and resembles the original design.
    # Verify that the number and name of the hotel are correct and sufficient compare the design.
    # Verify the calendar works correct to specifications and resembles the original design.
    # Defaults "Arrival" is the current day, month and year and "Departure" is a future date (1 day away from current date)
    # Verify that the single, double room price show on the calendar when logged in to the member account and not login member, correct to specifications  and resembles the original design.
    # Verify that the single, double room price show on the calendar when apply Voucher logged in to the member account and not login member,  show red highlights, correct to specifications  and resembles the original design.
    # Check Voucher with case enter correct and incorrect Voucher code, "Redeem code" button works have notifications, correct to specifications and resembles the original design.
    # Verify that the "Room, Adults, children" drop-down work correct with the specifications and resembles the original design.
    # Check the quantity of each room type (Windowless, Standard, Suite, Superior) and compare with the number of available rooms on Usage.
    # Check price of each room type (Windowless, Standard, Suite, Superior) and compare with price rooms type on Usage.
    # Check the "Add room, add Adults, Children, Breakfast, Close" buttons in UI. Active correct with specification.
    # Check the products on the bill your booking include (Room type, Arrival date, Departure date, Extra bed, Total, Remaining), is the display correct?
    # Check when add, remove the minimum, maximum number of adults and children of each room type  correct to specifications  and resembles the original design.
    # Check Voucher with case enter correct and incorrect Voucher code, User button works have notifications, same as specification.
    # Check "Equipment in each room" according to the design.
    # Check the pictures of each room type (Windowless, Standard, Suite, Superior) and check the content and spelling of each photo according to the design.
    # Check the content and spelling of breakfast, Adults, Children.
    # Check that the "Continue" button works correct to specifications and resembles the original design.
    # Check that the "Up, Down" button works correct to specifications and resembles the original design.
    # Prevent login page from SQL injection attack
    # Verify can add ECI/LCO if with true information
    # Verify that overview auto add ECI/LCO when click select ECI/LCO
    # Verify that ECI/LCo drop-down same as design 
    # Verify that ECI/LCO drop-doơn inlude data same as specification
    # Verify that SECIF will sells for same day booking 
    # verify that pricing of SECIF/ECI/LCO display same as set on MUI
    # Verify that Pricing of SECIF/ECI/LCo in overview display correctly
    # Check equiment of each room same as specification or not
    # Check image of each type room same as specification or not
    # Check breakfast same as design
    # Check add breakfast by click Add button
    # Check breakfast pop-up appear by clicking Add button
    # Check Breakfast pop-up UI same as per design
    # Verify info of restaurant serve breakfast(image,info) same as specification or not
    # Verify that auto selected No breakfast option in the fisrt time access add breakfast pop-up
    # Verify that can select any option in breakfast and can save it
    # Verify that can cancel when select breakfast
    # Verify that Add breakfast pop-up will be close when click one of Cancel/ Save button
    # Verify that breakfast auto add when add breakfast in add breakfast pop-up
    # Verify that can change number of breakfast by clicking change button or not
    # Verify that number of breakfast as last previous select
    # Verify can change number of breakfast  by select number of guest and clicking save button
    # Verify that amount corresponding to the number of guests of breakfast
    # verify that Compensate same as specification or not
    # Verify that Compensate your stay pop-up appear when click read more or not
    # verify that Compensate your stay pop-up same as per design
    # verify that Compensate your stay pop-up will close by clicking Close button or not
    # Verify that Compensate your stay pop-up will close by clicking "X" icon in the right top corner or not
    # Verify that can remove Compensate by clicking remove button
    # Verify that can add guest in the room by click +/- button 
    # Verify Extra bed auto add when increasing number of suest in the room
    # Verify that tghe number of breakfasts decreases when the number of guests is reduced 
    # verify that max guest in the room same as specification or not
    # Verify that Min guest in the room same as specification
    # verify that Extra bed decreases when then number of guests is reduced
    # Verify that can add or remove Extra single bed by click button add/remove
    # verify that extra bed auto add in overview whhen increasing number of guest or add extra single bed
    # verify that picing of extra bed same as specification
    # verify that all case with single room
    # verify extras page with 4 language (english, finland,rus,sv) same as specification or not
    # Verify extras page with member/ no-member
    # Verify that Continue to payment button same as specification
    # verify all spellings mistakes on Extras page 
    # verify time and info of hotel make reservation
    # verify that redeem your caimpaign code pop-up appear when click I have a campaign code in overview 
    # verify total pricing correctly or not
    # verify that all info in overview in payment page same as selector as previous in Extras page
    # Check extra page with booking make by admin 
    # Check Wheelchair accessible checkbox as per design or not
    # Check overview with edit pricing 
    # Verify Your booking overview 
    # verify that  Compensate can add in overview by click Add+... button

Verify Booking Process Step 3 Forms and Pages
    Pass Execution    TBD
# Check the checkboxes
# Fill in all the information before payment.
# Check the view boxes 
# Notifications when entering the wrong email, existed
# Payment by Web bank payment
# Payment by Card payment
# Payment by Invoice
# Payment by Redeem Omena gift card
# Check the checkboxes
# Fill in all the information before payment.
# Check the view boxes 
# Notifications when entering the wrong email, existed
# Payment by Web bank payment
# Payment by Card payment
# Payment by Invoice
# Payment by Redeem Omena gift card
# Check the checkboxes
# Fill in all the information before payment.
# Check the view boxes 
# Notifications when entering the wrong email, existed
# Payment by Card payment
# Payment by Redeem Omena gift card


# verify that can access comfirmation page 
# Verify Total cost same as per when make booking
# Verify time of reservation
# verify number of rooms, guests( Adult, Child)
# Verify Guest information 
# Verify warning message when not yet full fill info of guest 
# Verify that Edit guest pop-up appear when click into guest 
# verify Edit guest pop-up UI same as specification or not
# Verify Firsrt Name field
# Verify Last Name field
# Verify Email field
# verify Phone number field
# Verify Country dropdown
# Verify Nationality search function
# Verify nationality dropdown list
# Verify Country dropdown list
# Verify SSN/Passport filed
# Verify city field
# Verify Streer address
# Verify Postal code
# Verify Travelling for work check box
# Verify Someone elsse will be the main guest check box
# Verify that Edit guest pop-up will be close by click cancel/save/ "X" icon in the right top of pop-up
# Verify that redirect to my booking page when clicing in My bookings linked
# Verify all case for member, non-member, admin