*** Variables ***
${browser}        chromium
${timeout}        90s
${firstName}      Mos
${lastName}       Def

${emailUsername}  nelsontestar
${emailDomain}    gmail.com
${email}          ${emailUsername}@${emailDomain}
${phone}          0401234567
${btnPayment}    (//div[contains(@view,"extras")]//button[contains(text(), "Continue to payment")])[1]
${btnExtras}     (//div[contains(@view,"booking")]//button[contains(text(), "Continue to extras")])[1]
${ssn}           170479-371J
${url}           http://test4.omenahotels.com/en/
${testerEmail}   nelsontestar@gmail.com
${password}      Hello@123
${btnSaveAndSign}    //button[normalize-space()='Save and Sign']
${btnSave}        //button[normalize-space()='Save']
${muiname}        NO REAL EMAILS AND PASSWORDS AS PLAIN TEXT IN CODE
${muipass}        NO REAL EMAILS AND PASSWORDS AS PLAIN TEXT IN CODE