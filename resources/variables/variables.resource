*** Variables ***
${browser}        chromium
${timeout}        90s
${firstName}      Mos
${lastName}       Def

${emailUsername}  nelsontestar
${emailDomain}    gmail.com
${fullEmail}          ${emailUsername}@${emailDomain}
${phone}          0401234567
${btnPayment}    (//div[contains(@view,"extras")]//button[contains(text(), "Continue to payment")])[1]
${btnExtras}     (//div[contains(@view,"booking")]//button[contains(text(), "Continue to extras")])[1]
${ssn}           170479-371J
${btnSaveAndSign}    //button[normalize-space()='Save and Sign']
${btnSave}        //button[normalize-space()='Save']
${password}      NotARealPass123!
${bookingNumber}