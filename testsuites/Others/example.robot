*** Settings ***
Resource           ${EXECDIR}/resources/keywords/common.resource
Suite Teardown     Close Browser
Force Tags         skip

*** Test Cases ***


Open Nelson Portal    
    New Browser    ${browser}    false
    New Context
    ${url}=         EnvHandler.Get Environment Variable    MUI_LINK
    New Page        ${url}

Login Nelson Portal
    ${password}=    EnvHandler.Get Environment Variable    MUI_PASSWORD
    ${username}=    EnvHandler.Get Environment Variable    MUI_USERNAME
    Type Secret     id=loginUsername    ${username}
    Type Secret     id=loginPassword    ${password}