** Variables **

# GENERAL SETUP VARIABLES
${browser}        chromium
${timeout}        30s
${longer}         90s
${e}
${headless}       True
# FORM DATA
${firstName}      Mos
${lastName}       Def
${emailUsername}  nelsonsqa
${emailDomain}    gmail.com
${fullEmail}          ${emailUsername}@${emailDomain}
${phone}          401705972
${ssn}           170479-371J
${ytunnus}       
${city}         Vaasa
${address}      Vaasankatu 12
${postalCode}   00700
${phone.no.zero}  401705972
${companyName}  Company Co
${companyRef}   ReferenceNo
${companyVat}   ABC123
${guestFirstname}  Shin
${guestLastname}  Suke
${childFirstname}   Dong
${childLastname}    Dong
${password}      NotARealPass123!
${bookingNumber}
${bookingUUID}
${chilDateofbirth}  05/06/2022
${hotelName}      Helsinki, Lönnrotinkatu
${BDCNo}     547370586    #Default for debug, is overridden in full test suite run
${BDCHotelId}    10304890
${isBrowserOpen}    False
${phone.uk}    01333344552

# MAILSLURP RELATED 
${inbox_id}     35ac21dc-e785-4cad-8949-6f32023a286d
    # Secondary: 492aa3bb-9e4b-410a-a02c-84f13ace89e8    
    # Static Email that in Mailslurp, name Nelson-Test
    # ${MAILSLURP_API_KEY} is set in environment variables 

# CREDIT CARDS FOR TESTING
${cc.name}            Donald Trump
${cc.tyl.visa}        4147463011110083
${cc.tyl.master}      5239290700000028
${cc.tyl.code}        777
${cc.expedia}    4925000000000004
${cc.expedia.exp}    11/23
${cc.bdc.visa}    4153013999700321
${cc.bdc.exp.month}    11
${cc.bdc.exp.year}     2023
${cc.bdc.cvc}          321
${cc.omena.visa}     4153013999700024
${cc.omena.exp}    11/2023
${cc.omena.cvc}     024

# URLS
${url.bdc.test.omena}    https://secure.booking.com/book.html?hotel_id=2752157&test=1
${url.bdc.test.salo} 
${url.bdc.test.kensington} 
${microservice_url}        https://softico-dev-agent.frendsapp.com/api/qa/v1
${ks_home_url}            https://test.kensingtonstay.com
${url.test.ks_home}    https://test.kensingtonstay.com
${url.test.mui_login_test}
${url.prod.mui_login}
${url.prod.ks_home}    https://kensingtonstay.com
${url}          https://test4.omenahotels.com/en
${url.landing.page}
${BDCUrl}       https://secure.booking.com/book.html?hotel_id=
${MUI_URL}      https://admin.nelson.management/#/login

# INITS & OTHER TO BE CHECKED
${doorcodeRegex}    ^\d{5}$
${element_text}   'This field is required!'

${INBOX_ID}