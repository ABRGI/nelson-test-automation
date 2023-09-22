*** Variables ***

# Technically the same as variables.resource but in case these want to be separated
${locator}        //a[@class, 'someclass']
${muiResultTable}     //table[contains(@class, 'custom-table')]
${btnSaveAndSign}    //button[normalize-space()='Save and Sign']
${btnSave}        //button[normalize-space()='Save']
${btnPayment}    (//div[contains(@view,"extras")]//button[contains(text(), "Continue to payment")])[1]
${btnExtras}     (//div[contains(@view,"booking")]//button[contains(text(), "Continue to extras")])[1]