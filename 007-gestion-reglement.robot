*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${UserName}       admin
${pwd}            admin
${ccp}            compte_1
${client}         Client_1
${espace}         Espace facturation et paiement
${formulaire}     Nouvelle facture
${produit}        produit_1

*** Test Cases ***
connexion
    Open browser    http://192.168.0.18/dolibarr    chrome
    Click element    Xpath=//*[@id="username"]
    Input Text    Xpath=//*[@id="username"]    ${UserName}
    Click element    Xpath=//*[@id="login_right"]
    Input Password    Xpath=//*[@id="password"]    ${pwd}
    Click button    Xpath=//*[@id="login_line2"]/input
    Page Should Contain Element    Xpath=//*[@id="id-right"]/div/table/tbody/tr/td[2]/div

CT-SN-creer-compte-bancaire
    [Documentation]    Précondition: être connecté a Dolibarr en administrateur
    ...    Données entrée: réf, libellé, type de compte,devise, état, pays du compte, compte comptable
    ...    Donnée sortie: Fiche du compte créé
    ...    Post-condition: Le compte est créé, le système affiche la 'fiche' du compte
    Click Element    //*[@id="mainmenutd_bank"]/div/a[1]/div
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    #ref
    Click element    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[1]/td[2]/input
    input text    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[1]/td[2]/input    compte_1
    #libelle
    Click Element    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[2]/td[2]/input
    Input Text    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[2]/td[2]/input    compte_1
    #choix pays
    click element    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[6]/td[2]/span/span[1]/span
    input text    //*[@id="mainbody"]/span/span/span[1]/input    france
    press key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    #créer button
    Click element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Page should contain    \    compte_1
    click element    //*[@id="mainbody"]/div[7]/div/a
    sleep    2s

CT-SN-creer-facture-client
    [Documentation]    \#Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir créé ‘journal comptable’, avoir ‘Client_1’ créé, avoir un ‘compte’ créé    #Données entrées : client, type, date facturation, condition de règlement    #Données sorties : Fiche facture client    #Post-conditions : la fiche de règlement est créée    #Résultat attendu : Le système affiche la fiche de règlement, clonable et supprimable
    # Cliquer sur l'onglet Facturation/paiement
    Click Element    //*[@id="mainmenutd_billing"]/div/a[1]/div
    # Vérifier que la page d'espace facturation et paiement est ouverte
    Element Should Contain    //*[@id="id-right"]/div/table/tbody/tr/td[2]/div    ${espace}
    # Cliquer sur Nouvelle facture sous Factures clients
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]
    # Vérifier que la page de formulaire de création de facture
    Element Should Contain    //*[@id="id-right"]/div/table/tbody/tr/td[2]/div    ${formulaire}
    # Sélection du Client
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[2]/td[2]/span/span[1]/span/span[2]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ${client}
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    # Choix de la date
    Click Element    //*[@id="reButtonNow"]
    # Choix des Conditions de règlement
    Select From List By Value    //*[@id="cond_reglement_id"]    7
    # Valider la création du brouillon
    Click Button    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérifier la création du brouillon de la facture
    #Element Should Be Visible    //*[@id="id-right"]/div/div[1]/a/span
    #Element Should Be Enabled    //*[@id="id-right"]/div/div[1]/a/span
    #Element Should Be Enabled    //*[@id="id-right"]/div/div[3]/div[2]/a
    # Valider le brouillon
    # Selectionner le produit
    Click Element    //*[@id="tablelines"]/tbody/tr[2]/td[1]/span[2]/span/span[1]/span/span[2]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ${produit}
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    # Entrer une note
    sleep    2s
    Click Element    //*[@id="dp_desc"]
    Press Keys    //*[@id="dp_desc"]    test
    # Ajouter le produit
    Click Button    //*[@id="addline"]
    # Vérifier que l'on peut valider le brouillon
    Element Should Be Visible    //*[@id="id-right"]/div/div[3]/div[1]/a
    # Valider le brouillon
    Click Element    //*[@id="id-right"]/div/div[3]/div[1]/a
    # Vérifier que la fenetre confirmation s'ouvre
    Sleep    2s
    Page should contain    \    Valider
    # Confirmer la validation de facture
    Click Button    //*[@id="mainbody"]/div[15]/div[3]/div/button[1]
    # Vérifier que la facture passe en status impayée
    Element text Should Be    //*[@id="id-right"]/div/div[2]/div[1]/div/div[2]    Impayée

CT-SN-reglement-facture
    [Documentation]    Postcondition: avoir une facture impayée, avoir un compte créé
    ...    données entrées: date, mode de reglement, compte a créditer, montant réglement
    ...    donées sortie:
    Click Element    //*[@id="mainmenutd_billing"]/div/a[1]/div
    #facture impayée
    Click Element    //*[@id="id-left"]/div/div[3]/div[4]/a
    Click Element    //*[@id="id-left"]/div/div[3]/div[6]
    #selection facture
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[3]/td[1]/table/tbody/tr/td/a
    # bouton saisir reglement
    Click Element    //*[@id="id-right"]/div/div[3]/div[3]/a
    Click Element    //*[@id="reButtonNow"]    #date
    Click Element    //*[@id="selectpaiementcode"]    #moderéglement
    Click Element    //*[@id="selectpaiementcode"]/option[3]
    Click Element    //*[@id="payment_form"]/div[3]/input[2]
    #compte a créditer
    click element    //*[@id="selectaccountid"]
    click element    //*[@id="selectaccountid"]/option[2]
    #montant réglé
    Click Element    //*[@id="payment_form"]/table/tbody/tr[2]/td[7]/input[2]
    Input Text    //*[@id="payment_form"]/table/tbody/tr[2]/td[7]/input[2]    100
    Click Element    //*[@id="payment_form"]/div[3]/input[2]
    #valider paiement
    click element    //*[@id="payment_form"]/table[2]/tbody/tr[3]/td[3]/input
    Page should contain    \    Payée

CT-SE-creer-facture-client
    [Documentation]    \#Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir créé ‘journal comptable’, avoir ‘Client_1’ créé, avoir un ‘compte’ créé    #Données entrées : client, type, date facturation, condition de règlement    #Données sorties : Fiche facture client    #Post-conditions : la fiche de règlement est créée    #Résultat attendu : Le système affiche la fiche de règlement, clonable et supprimable
    # Cliquer sur l'onglet Facturation/paiement
    Click Element    //*[@id="mainmenua_billing"]/span
    click element    //*[@id="id-left"]/div/div[3]/div[3]
    # Vérifier que la page d'espace facturation et paiement est ouverte
    # Cliquer sur Nouvelle facture sous Factures clients
    # Vérifier que la page de formulaire de création de facture
    Element Should Contain    //*[@id="id-right"]/div/table/tbody/tr/td[2]/div    ${formulaire}
    # Sélection du Client
    # Choix des Conditions de règlement
    # Valider la créatiofn du brouiinpullon
    Click Button    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérifier le message d'erreur lors de la validation
    Element Should Be Visible    //*[@id="mainbody"]/div[7]/div/div[2]/div
    # Cliquer sur la croix pour fermer la fenetre du message d'erreur
    Click Element    //*[@id="mainbody"]/div[7]/div/a
    Sleep    2s

deconnexion
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[3]/div
