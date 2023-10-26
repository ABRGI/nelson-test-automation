*** Settings ***

Suite Setup         Open Browser to Nelson Portal and Login
Suite Teardown    Close Browser
Resource           ${EXECDIR}/resources/keywords/common.resource
Resource           ${EXECDIR}/resources/keywords/booking.resource
Resource           ${EXECDIR}/resources/keywords/mui.resource
Documentation      A test suite for verifying modify booking functionality
Force Tags         smoke

*** Test Cases ***    

Reservations: Filter all reservations with Check-in incomplete
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled onOpen Browser to Nelson Portal and Login
  Set Browser Timeout   15s
  Select Hotel for Search    
  Toggle Check in incomplete filter button
  Click Search Button
  Select First Found Reservation
  Click Reservations from Navigation Menu
  Pass Execution     TBD: Verifications for the reservation

Reservations: Remove filter and find a reservation with Check-in complete
  [Documentation]   Test case verifying the functionality of the Check in incomplete filter
  ...               when it's toggled off
  Select Hotel for Search    
  Click Search Button
  Select First Found Reservation
  Pass Execution     TBD: Verifications for the reservation

Reservations: Filter Reservations by Stay Dates
  [Documentation]   Test case verifying the functionality of the Departing Today filter
  ...               when it's toggled on
  Toggle Departing Today
  Toggle Staying Tonight
  Toggle Arriving Today
  Click Reservations from Navigation Menu

Verify all things 
    [Documentation]    Placeholder for now
    Pass Execution     TBD
    # Verify all values addesd in Hotel dropdown list or not
    # Verify that the label text for the Hotel dropdown should be as per requirements and aliggned or not
    # Verify on click on the Hotel dropdown it should display a list containing values
    # Verify that the Hotel dropdown displays all values or not as the user clicks on the dropdown
    # Verify that the by default selected value is shown on the dropdown or not
    # Verify that the Hotel dropdown should not be editable
    # Check the order of the values in the Hotel dropdown list same as the requirement or not
    # Check that there should not be any blank value show in the Hotel dropdown list
    # Verify Hotel dropdown values case sensitive or not as a system required
    # Verify that the Hotel dropdown values should be accessible and selected by clicking  on the alphabet from the keyboard
    # Test Hotel dropdown list design should no be disturbed on all browsers
    # Check spelling for the values in the Hotel dropdown list
    # verify all the values in Hotel dropdown align or not
    # Verify on mouse hover mouse pointer change from a pointer to hard or not
    # verify that proper spacing is added on the Hotel dropdown values or not
    # Verify mouse hover effect is added for the Hotel dropdown list or not
    # Check that date picker get open when user click on date field
    # Verify that user able to select the date from the date picker
    # Verify that by default current date selected or not when date picker get open
    # Verify that current date highlight by default or not
    # Verify that date picker get closed or not when user select the date from fate picker
    # Verify that date picker get closed or not when user click outside od date field
    # Verify that user able to change the date or not once selected from date picker
    # Verify that the selected sate showing in date field or not
    # verify that date showing in valid format or not when user select from date picker
    # Verify that user able to swipe the previous month or year from arrow( forward and bakward ) option in date picker
    # Verify that date showing disable or not
    # Check that when user try to select the which are not in boundary
    # Verify that the user able to change the date or not when date masking applied on field
    # Verify the button Apply work normally
    # Verify the search functionality by entering the Apply button
    # Verify the result show as per search
    # Check the time take by the system to display the result 
    # Verify the loading symbol when the page take more time to display the result
    # Verify the search function if auto-suggestion is there
    # Verify Edit Channels button work by clicking the button
    # Verify all functionality of Edit Channel work as per specification
    # Verify that Edit channel pop-up should close by clicking Close button 
    # Verify that number of buffer for multiple days should apply for table when click Apply button
    # Verify that anything change in table channel should be save when click Save button
    # Verify that Edit channel pop-up will be close and change as per when we change by click Save &Close button.
    # Verify that date picker in Edit channel work as per specification
    # Verify Channel table with negative number
    # Verify that Edit channels pop-up close when click on X icon
    # Verify that the ECI/LCO should be open by clicking ECI/LCo button
    # Verify search fuctionality in ECI/LCO  pop-up 
    # Verify date picker in ECI/LCO pop-up should be work normally as specification
    # Verify UI of ECI/LCO pop-up should be same as specification
    # Verify that status open or not of ECI/LCO should be change by clicking in Open row
    # (radio) Check if the radio is present on the ECI/LCO pop-up as per design
    # Check whether the radio button are selectable or unselectable
    # Check the shape of the radio button as per specification 
    # Check if the color and style of the radio button are as per the requirement document or not
    # Check if the radio button is selectable by using the tab on key board
    # Check the aligment of the radio button on the ECI/LCO pop-up
    # Check if the user is able to select mutilple radio button
    # Check the style , color and size of the radio button as per the requirement document
    # Check without selecting any radio button if the  user click submits then is the alert mesage is displaying or not
    # Check on the "yes" radio button control and hit submit to see it show true result or not
    # Check on the "no" radio button control and hit submit to see it show true result or not
    # Check if the user select yes then the corect date should be saved on the database
    # Check on clicking the lable and check whether the radio button is selected or not
    # Check on the selection of the radio button respective web element open or not
    # Check aligment of the radio button and label text in all browser
    # Check the default selecteion of the radio button as per SRS document
    # verify that the ECI/LCO pop -up should be close by clicking one of button Close/Save&Close
    # Verify that table can pull as per horizontal pull bar in ECI/LCo pop-up
    # verify Allotment should show on Usage table by click Show allotment button
    # Verify Show allotment button
    # Verify the show legend button 
    # Verify that the legend should be show by clicking Show legend button
    # verify that number of legend same as specification
    # Verify that color of each legend match with design
    # Verify usage table same as specification
    # Verify that Maintenance page same as specification
    # Check that date picker get open when user click on date field
    # Verify that user able to select the date from the date picker
    # Verify that by default current date selected or not when date picker get open
    # Verify that current date highlight by default or not
    # Verify that date picker get closed or not when user select the date from fate picker
    # Verify that date picker get closed or not when user click outside od date field
    # Verify that user able to change the date or not once selected from date picker
    # Verify that the selected sate showing in date field or not
    # verify that date showing in valid format or not when user select from date picker
    # Verify that user able to swipe the previous month or year from arrow( forward and bakward ) option in date picker
    # Verify that date showing disable or not
    # Check that when user try to select the which are not in boundary
    # Verify that the user able to change the date or not when date masking applied on field
    # Verify the Search button work normally
    # Verify the search functionality by entering the Apply button
    # Verify the result show as per search
    # Check the time take by the system to display the result 
    # Verify the loading symbol when the page take more time to display the result
    # Verify the search function if auto-suggestion is there
    # Verify UI of Create maintenance page should be same as specification
    # Verify hotel dropdown
    # Verify Floor dropdown and Available Rooms dropdown
    # Check number of available room same as with specification and database
    # Verify button move room
    # Verify that functionality move room from Available room to Select room work as per SRS document
    # Verify that Create Maintenance  successfull
    # Verify that redirect to usge page when create maintenance successful or not
    # Verify that edit maintenance UI as per design
    # Verify that can edit maintenance successfully
    # Verify Update button work as expected
    # Verify that can Cancel maintenance  when clicking Cancel button
    # Verify that can view maintenance in usage page by click View Usage button
    # verify that can change Maintenance category 
    # Check UI when redirect to Pricing page
    # Check the drop button at Search by hotel to see if it shows the choose form.
    # Check the drop button at Product type to see if it shows the choose form.
    # Check calendar at Start date and End date to see if it works right or wrong
    # Test checkbox to see if it works.
    # Check the reset button when a new price has been saved
    # Check the reset button when a new price has not been saved
    # Check the reset button when you have entered a new price
    # Check reset button without entering a new price
    # Test edit button at rules
    # Check price with decimals, negative numbers
    # Check Drop Button at the unit
    # Check the Increment Buttons at rules to determine no negative numbers
    # Test input text when click reset/save button
    # Check UI when redirect to Voucher page
    # Check if the buttons works
    # Confirm not to null input type (Name for normal discount, Amount, Decription, attached requests of Type)
    # Check if voucher creation is successful when the required requirements have been satisfied 
    # Check the voucher for the hotel is not selected
    # Check the voucher for the day of no selection
    # Check the price after entering the voucher
    # Check the parameters after editing
    # Checking the floating notifications is reasonable yet
    # Check voucher for nights smaller than Min Nights and greater than Max Nights
    # Check if the search filter is working
    # Check UI of breakfat page smae as specification 
    # Check that can set available for breakfast
    # Check that can set unavailable for breakfast
    # Check that can set price for breakfast
    # Check that breakfast available when buy extras in BUI
    # Check that breakfast unavailable when buy extras in BUI
    # Check price of breakfast when buy extras in BUI
    # Check can set restaurant email
    # Check UI of allotment page same as specification
    # Verify that can create soft allotment success
    # Verify that can create hard allotment success
    # Verify date picker should be work normally as specification
    # Verify drop-down same as specification
    # Verify that can edit allotment or not
    # verify that can cacncel allotment or not
    # Verify that can redirect to usage page by clicking on see usage if harrd allotment
    # Verfy that information show in usage tabke same as when create allotment
    # Verify that search functionality in allotment page work normally
    # Verify that result when search as per expected
    # verify that Select report drop-down same as specification
    # Verify that date picker same as specification
    # Veify that Hotel drop-down include hotel information as per design
    # Verify that can select one report in Select report dropdown
    # Verify that Shortcuts button can clickable 
    # Verify that Shortcuts that work normally as document
    # Verify that Download Guests In-House button can clickable or not
    # Verify that Download Report button can clickable or not
    # Verify spelling of all component in report page
    # Verify that can download all report by click download report or not
    # Check data in Breakfast report 
    # Check data in Cleaning report
    # Check data in Daily availability Report
    # Check data in Guest Report
    # Check data in Guest Mobile Numbers Report
    # Check data in On the Books report
    # Check data in Revenue report
    # Check data in Revenue Report NEW
    # Check data in Sales Report
    # Check data in Unpaid Expedia Reservataion Report
    # verify that can access mybooking page when clicking My booking in  member drop-down
    # Verify that My bookings page same as specification
    # Verify that My bookings page include two component is Upcoming and Past
    # Verify that Upcoming include all reservation make by this member in the future or now
    # Verify that Past include all reservation make by this member in this past
    # verify that Upcoming include above cancel reservation in the future make bu this member
    # Verify that Past include ablove cancel reservation in this past
    # Verify that can access all reservation display with true information or not
    # verify that can access any reservation by clicking Manage button
    # verify Find my booking UI same as per requirement
    # Verify that can find my booking by click button "Search with booking details"
    # verify that Button "Search with booking details" same as design
    # Verify that Find my booking pop-up appear by click "Search with booking details"
    # Verify that Find my booking pop-up UI same as specification
    # Verify that can find booking with valid information
    # verify that can find booking with invalid information
    # Verify Find my booking button in Find my booking pop-up
    # Verify cancel button in Find my booking pop-up
    # Verify that redirect to my booking include this reservation info
    # Check find my booking with member
    # Check find my booking with non-member
    # Check find my booking with ext-channel booking (expedia, BDC)
    # Check find my booking with reservation is pending of member
    # Check find my booking with reservation is pending of non-member
    # Check find my booking with reservation is pending of ext-channel
    # Check my booking page with 4 language(fin,eng,rus,sv)
    # Check Find my booking with 4 language (fin,eng,rus,sv)