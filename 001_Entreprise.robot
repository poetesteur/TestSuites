*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${login}          admin
${password}       admin

*** Test Cases ***
CT-Connexion
    Open browser    http://192.168.0.18/dolibarr    chrome
    Sleep    2s
    Click Element    xpath=//*[@id="username"]
    Input Text    xpath=//*[@id="username"]    ${login}
    Textfield Value Should Be    xpath=//*[@id="username"]    ${login}
    Click Element    xpath=//*[@id="password"]
    Input Password    xpath=//*[@id="password"]    ${password}
    Click Button    xpath=//*[@id="login_line2"]/input

CT-SN-creer-prospect
    [Documentation]    CT-SN-Créer Prospect
    ...    Préconditions : être connecté à Dolibarr en tant qu’administrateur
    ...    Données entrées : ‘Nom du tiers’, ‘prospect/client’, ‘fournisseur’
    ...    Données sorties : Fiche tiers
    ...    Post-condition : Le système affiche la fiche du Tiers avec données entrées
    ...    Résultat attendu : Le Prospect_1 est créé dans BDD
    # Clique sur Tiers dans le bandeau ; vérification que la bonne page est chargée
    Click Element    //*[@id="mainmenua_companies"]
    Sleep    1s
    Element Should Be Visible    //*[@id="id-right"]/div/table/tbody/tr/td[2]/div
    # Clique sur 'Nouveau Tiers' puis les champs obligatoires sont complétés
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    Input Text    //*[@id="name"]    Prospect_1
    Textfield Value Should Be    //*[@id="name"]    Prospect_1
    # Selection par index Client/Prospect: 1=Prospect
    Select From List By Index    //*[@id="customerprospect"]    1
    # Selection par index fournisseur Oui/Non: 2=Non
    Select From List By Index    //*[@id="fournisseur"]    2
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Sleep    1s
    # Après création du prospect, vérification du nom puis du type de tiers (Prospect)
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[1]/div/div[4]    Prospect_1
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[3]/div[1]/table/tbody/tr[1]/td[2]    Prospect

CT-SN-creer-client
    [Documentation]    CT-SN-Créer Client
    ...    Préconditions : être connecté à Dolibarr en tant qu’administrateur
    ...    Données entrées : ‘Nom du tiers’, ‘prospect/client’, ‘fournisseur’
    ...    Données sorties : Fiche tiers
    ...    Post-condition : Le système affiche la fiche du Tiers avec données entrées
    ...    Résultat attendu : Le Client_1 est créé dans BDD
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    Input Text    //*[@id="name"]    Client_1
    # Selection par index Client/Prospect: 3=Client
    Select From List By Index    //*[@id="customerprospect"]    3
    # Selection par index fournisseur Oui/Non: 2=Non
    Select From List By Index    //*[@id="fournisseur"]    2
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Sleep    1s
    # Après création du client, vérification du nom puis du type de tiers (Client)
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[1]/div/div[4]    Client_1
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[3]/div[1]/table/tbody/tr[1]/td[2]    Customer

CT-SN-creer-fournisseur
    [Documentation]    CT-SN-Créer Fournisseur
    ...    Préconditions : être connecté à Dolibarr en tant qu’administrateur
    ...    Données entrées : ‘Nom du tiers’, ‘prospect/client’, ‘fournisseur’
    ...    Données sorties : Fiche tiers
    ...    Post-condition : Le système affiche la fiche du Tiers avec données entrées
    ...    Résultat attendu : Le Fournisseur_1 est créé dans BDD
    Click Element    //*[@id="mainmenua_companies"]
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    Input Text    //*[@id="name"]    Fournisseur_1
    # Selection par index Client/Prospect: 3=Client (on crée un client qui sera aussi fournisseur)
    Select From List By Index    //*[@id="customerprospect"]    3
    # Selection par index fournisseur Oui/Non: 1=Oui
    Select From List By Index    //*[@id="fournisseur"]    1
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Sleep    1s
    # Après création du client-fournisseur, vérification que l'élément 'Code Fournisseur' est présent, puis vérification du type de tiers (Client)
    Element Should Be Visible    //*[@id="id-right"]/div/div[2]/div[3]/div[1]/table/tbody/tr[4]/td[1]
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[3]/div[1]/table/tbody/tr[1]/td[2]    Customer

CT-SE-creer-client
    [Documentation]    CT-SE Créer client
    ...    Préconditions : être connecté à Dolibarr en tant qu’administrateur
    ...    Données entrées : ‘prospect/client’, ’fournisseur’
    ...    Données sorties : Message d’erreur
    ...    Post-condition : Le système demande un ‘Nom du tiers’
    ...    Résultat attendu : Le Tiers n’est pas créé, le système reste en attente
    Click Element    //*[@id="mainmenua_companies"]
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    # Pour ce CT d'exception, on laisse le champ Nom vide
    Select From List By Index    //*[@id="customerprospect"]    3
    Select From List By Index    //*[@id="fournisseur"]    1
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    # On vérifie que le message "Le champ 'Nom du tiers' est obligatoire" apparait
    Element Should Be Visible    //*[@id="mainbody"]/div[8]/div/div[2]/div
    Click Element    //*[@id="mainbody"]/div[8]/div/a
    Sleep    1s

CT-Deconnexion
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[3]/div/a/span
    Element Should Be Visible    xpath=//*[@id="login_line2"]/input
