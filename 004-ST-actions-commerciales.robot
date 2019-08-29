*** Settings ***
Suite Teardown    Close All Browsers
Library           SeleniumLibrary

*** Variables ***
${UserName}       admin
${pwd}            admin

*** Test Cases ***
connexion-admin
    Open browser    http://192.168.0.18/dolibarr/    chrome
    Click element    Xpath=//*[@id="username"]
    Input Text    Xpath=//*[@id="username"]    ${UserName}
    Click element    Xpath=//*[@id="login_right"]
    Input Password    Xpath=//*[@id="password"]    ${pwd}
    Click button    Xpath=//*[@id="login_line2"]/input
    Page Should Contain Element    Xpath=//*[@id="id-right"]/div/table/tbody/tr/td[2]/div

CT-SN-nouvelle_commande_client
    [Documentation]    Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘tiers1’ créé
    ...    Données entrées : ‘réf’, ‘client’, ‘date’, ‘durée de validité’
    ...    Données sorties : Fiche proposition brouillon
    ...    Post-conditions : la proposition est créée
    ...    Résultat attendu : la fiche proposition clonable et supprimable s’affiche
    Click Element    //*[@id="mainmenua_commercial"]/span
    Click Element    //*[@id="id-left"]/div/div[5]/div[3]/a
    #champs déroulant Tiers
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[3]/td[2]/span/span[1]/span
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    Client_1
    Press key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    #selection date
    Click Element    //*[@id="reButtonNow"]
    #boutton créer
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Page Should Contain    \    Fiche Commande

CT-SN-nouvelle_commande_fournisseur
    [Documentation]    Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘tiers1’ créé
    ...    Données entrées : ‘supplier’
    ...    Données sorties : fiche commande
    ...    Post-conditions : le brouillon de commande est créé
    ...    Résultat attendu : le système affiche la ‘fiche commande’ clonable et supprimable
    Click Element    //*[@id="mainmenua_commercial"]/span
    Click Element    //*[@id="id-left"]/div/div[6]/div[3]/a
    #champs déroulant supplier
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[2]/td[2]/span/span[1]/span/span[2]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    Fournisseur_1
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    #bouton créer
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Page should contain    \    Fiche Commande

CT-SE-nouvelle_commande_client
    Click Element    //*[@id="mainmenua_commercial"]/span
    Click Element    //*[@id="id-left"]/div/div[5]/div[3]/a
    #pas de selection de client
    Click Element    //*[@id="reButtonNow"]
    #boutton créer
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    #message erreur
    Page Should Contain Element    //*[@id="mainbody"]/div[7]/div/div[2]
    Click Element    //*[@id="mainbody"]/div[7]/div/a
    Sleep    1s

deconnexion
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[4]/div/a/span
