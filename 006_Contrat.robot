*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${login}          admin
${password}       admin

*** Test Cases ***
CT-Connexion
    Open browser    http://192.168.0.16    chrome
    Sleep    2s
    Click Element    xpath=//*[@id="username"]
    Input Text    xpath=//*[@id="username"]    ${login}
    Textfield Value Should Be    xpath=//*[@id="username"]    ${login}
    Click Element    xpath=//*[@id="password"]
    Input Password    xpath=//*[@id="password"]    ${password}
    Click Button    xpath=//*[@id="login_line2"]/input

CT-SN-creer-contrat
    [Documentation]    Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘Client_1’ créé
    ...    Données entrées : tiers, commercial suivi de du contrat, commercial signataire du contrat, date
    ...    Données sorties : fiche contrat
    ...    Post-conditions : la fiche contrat est créée
    ...    Résultat attendu : Le système affiche la fiche contrat, , clonable, supprimable
    # Clique sur Commercial dans le bandeau : vérification que la bonne page est chargée
    Click Element    //*[@id="mainmenua_commercial"]
    Element Should Be Visible    //*[@id="id-right"]/div/table/tbody/tr/td[1]/img
    # Clique sur Nouveau Contrat/abonn.
    Click Element    //*[@id="id-left"]/div/div[7]/div[3]/a
    # Seul le champ Tiers doit être complété (les autres champs obligatoires sont préremplis)
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[4]/td[2]/span/span[1]/span/span[2]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    Client_1
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Sleep    2s
    # Ajout d'un service sur la fiche contrat (indispensable pour valider le contrat)
    Element Should Be Visible    //*[@id="card"]
    Click Element    //*[@id="cke_1_contents"]/iframe
    Press Keys    //*[@id="cke_1_contents"]/iframe    ServiceTest
    Input Text    //*[@id="price_ht"]    15
    Click Element    //*[@id="addline"]
    # Validation du contrat
    Click Element    //*[@id="id-right"]/div/div[3]/div[1]/a
    Sleep    2s
    Click Element    //*[@id="mainbody"]/div[17]/div[3]/div/button[1]
    #    Vérification de la présence du bouton modifier (apparait seulement si le contrat est validé)
    Element Should Be Visible    //*[@id="id-right"]/div/div[3]/div[2]/a
    # Suppression du contrat
    Click Element    //*[@id="id-right"]/div/div[3]/div[8]/a
    Click Element    //*[@id="mainbody"]/div[20]/div[3]/div/button[1]
    Page Should Not Contain    Client_01

CT-SE-creer-contrat
    [Documentation]    Précondition : être connecté à Dolibarr en tant qu’administrateur
    ...    Données entrées : commercial suivi de du contrat, commercial signataire du contrat, date
    ...    Données sorties : fiche contrat
    ...    Post-conditions : la fiche contrat n'est pas créée
    ...    Résultat attendu : Le système reste dans l’attente, le champ ‘tiers’ est obligatoire
    # Clique sur Commercial dans le bandeau : vérification que la bonne page est chargée
    Click Element    //*[@id="mainmenua_commercial"]
    Element Should Be Visible    //*[@id="id-right"]/div/table/tbody/tr/td[1]/img
    # Clique sur Nouveau Contrat/abonn.
    Click Element    //*[@id="id-left"]/div/div[7]/div[3]/a
    # SE : le champ Tiers (obligatoire) n'est pas complété
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérification que le message "Le champ 'Tiers' est obligatoire" apparait
    Element Should Be Visible    //*[@id="mainbody"]/div[7]/div/div[2]/div
    Click Element    //*[@id="mainbody"]/div[7]/div/a
    Sleep    1s

CT-Deconnexion
    Click Element    //*[@id="topmenu-login-dropdown"]/a/img
    Click Element    //*[@id="topmenu-login-dropdown"]/div/div[3]/div[2]/a
    Element Should Be Visible    xpath=//*[@id="login_line2"]/input
