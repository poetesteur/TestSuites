*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${login}          admin
${password}       admin
${client}         Client_1
${duree}          30
${fournisseur}    Fournisseur_1
${erreur}         Field 'Vendor' is required

*** Test Cases ***
CT-SN-Nouvelle-proposition-commerciale
    #[Documentation]
    #Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘Client_1’ créé
    #Données entrées : ‘réf’, ‘client’, ‘date’, ‘durée de validité’
    #Données sorties : Fiche proposition brouillon
    #Post-conditions : la proposition est créée
    #Résultat attendu : la fiche proposition clonable et supprimable s’affiche
    # Connexion
    Open Browser    http://192.168.0.18/dolibarr    chrome
    Input Text    //*[@id="username"]    ${login}
    Input Text    //*[@id="password"]    ${password}
    Click Button    //*[@id="login_line2"]/input
    # Vérifier que la page d'accueil s'ouvre
    #Location Should Be    http://192.168.0.18/admin/index.php?mainmenu=home&leftmenu=setup&mesg=setupnotcomplete
    # Créer proposition commerciale avec Client_1
    # Cliquer sur l'onglet Commercial
    Click Element    //*[@id="mainmenua_commercial"]/span
    # Vérifier que la page du menu commercial s'ouvre
    #Location Should Be    http://192.168.0.18/comm/index.php?mainmenu=commercial&leftmenu=
    # Cliquer sur nouvelle proposition commerciale
    Click Element    //*[@id="id-left"]/div/div[3]/div[3]/a
    # Vérifier que la page de formulaire de nouvelle proposition commerciale s'ouvre
    # Saisies des champs obligatoires
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[3]/td[2]/span/span[1]/span
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ${client}
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    Click button    //*[@id="reButtonNow"]
    input Text    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[5]/td[2]/input    ${duree}
    Click button    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérifier que la proposition est créée
    Element Should Be Visible    //*[@id="id-right"]/div/div[3]/div[1]/a
    Element Should Be Enabled    //*[@id="id-right"]/div/div[3]/div[2]/a

CT-SN-Nouvelle-demande-prix
    #[Documentation]
    #Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘Client_1’ créé
    #Données entrées : ‘supplier’
    #Données sorties : Fiche demande
    #Post-conditions : le demande de prix est créée
    #Résultat attendu : la fiche demande s’affiche, clonable et supprimable
    # Créer nouvelle demande prix
    # Cliquer sur l'onglet Commercial
    Click Element    //*[@id="mainmenua_commercial"]/span
    # Vérifier que la page du menu commercial s'ouvre
    #Location Should Be    http://192.168.0.18/comm/index.php?mainmenu=commercial&leftmenu=
    # Cliquer sur nouvelle demande de prix
    Click Element    //*[@id="id-left"]/div/div[8]/div[3]/a
    # Vérifier que la page de formulaire de nouvelle demandede prix s'ouvre
    # Sélectionner le fournisseur
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[2]/td[2]/span/span[1]/span/span[2]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ${fournisseur}
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    # Valider la demande de prix
    Click Button    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérifier que la demande est créée et que la page de fiche de demande est ouverte
    Element Should Be Visible    //*[@id="comm"]

CT-SE-Nouvelle-demande-prix
    #[Documentation]
    #Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘Client_1’’ créé
    #Données entrées : ‘réf’
    #Données sorties : Message d’erreur
    #Post-conditions : la demande n’est pas créée
    #Résultat attendu : Le système affiche un message d’erreur ‘champ supplier obligatoire ‘
    # Créer nouvelle demande prix
    # Cliquer sur l'onglet Commercial
    Click Element    //*[@id="mainmenua_commercial"]/span
    # Vérifier que la page du menu commercial s'ouvre
    #Location Should Be    http://192.168.0.18/comm/index.php?mainmenu=commercial&leftmenu=
    # Cliquer sur nouvelle demande de prix
    Click Element    //*[@id="id-left"]/div/div[8]/div[3]/a
    # Vérifier que la page de formulaire de nouvelle demandede prix s'ouvre
    # Valider la demande de prix sans remplir le champ obligatoire
    Click Button    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Vérifier que le message d'erreur apparaît
    Element Text Should Be    //*[@id="mainbody"]/div[7]/div/div[2]/div    ${erreur}
    # Fermer la fenetre du message d'erreur
    Click Element    //*[@id="mainbody"]/div[7]/div/a
    # Attendre que le message d'erreur ait disparu
    Sleep    2s
    # Deconnexion
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[3]/div/a
    # Vérifier que la page de login s'ouvre
    Location Should Be    http://192.168.0.18/dolibarr/index.php
    Close All Browsers
