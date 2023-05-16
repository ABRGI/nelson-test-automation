*** Settings ***
Resource           ${EXECDIR}/resources/keywords/common.resource
Suite Teardown     Close Browser

*** Test Cases ***
Search on Google
    Open Browser    https://www.google.com    chromium     headless=${headless}
    Fill Text       //textarea[@name="q"]   Robot Framework
    Press Keys      ENTER
    Close Browser
