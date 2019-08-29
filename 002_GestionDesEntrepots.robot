*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${Login}          admin
${Password}       admin

*** Test Cases ***
CT-SN-01-CreationDesEntrepots
    #Connexion
    Open browser    http://192.168.0.18/dolibarr    chrome
    Input Text    xpath= //*[@id="username"]    ${Login}
    Input Password    xpath= //*[@id="password"]    ${Password}
    Click Button    xpath= //*[@id="login_line2"]/input
    #Chemin jusqu'au formulaire
    Click Element    //*[@id="mainmenua_products"]
    Click Element    //*[@id="id-left"]/div/div[6]/div[3]/a
    #Formulaire de création d'entrepôt 1
    Input Text    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[1]/td[2]/input    ENT-001
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[1]/div/div[4]    ENT-001
    #Formulaire de création d'entrepôt 2
    Click Element    //*[@id="id-left"]/div/div[6]/div[3]/a
    Input Text    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[1]/td[2]/input    ENT-002
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[1]/div/div[4]    ENT-002
    #Deconnexion
    Sleep    5s
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[4]/div/a/span
