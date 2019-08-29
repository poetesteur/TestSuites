*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${Login}          admin
${Password}       admin
${StockPDT-01}    50
${RefProduit}     PDT-01

*** Test Cases ***
CT-SN-01-Connexion
    Open Browser    http://192.168.0.18/dolibarr/    chrome
    Input Text    xpath= //*[@id="username"]    ${Login}
    Input Password    xpath= //*[@id="password"]    ${Password}
    Click Button    xpath= //*[@id="login_line2"]/input

CT-SN-CreerStockProduit
    #[Documentation]    CT-SN-Créer-stock
    #...    Précondition : être connecté à Dolibarr en tant qu’administrateur, avoir ‘entrepôt1’ créé.
    #...    Données entrées : référence, libellé, état vente, état achat, entrepôt par
    #...    Défault’entrepot1’,’nombre de pièces1’
    #...    Données sorties : liste des produits, ‘produit1’
    #...    Post-condition : le produit est créé avec son stock et emplacement défini
    #...    Résultat attendu : Le stock produit est créé et modifiable dans BDD
    Click Element    //*[@id="mainmenutd_products"]/div/a[1]
    Click Element    //*[@id="id-left"]/div/div[4]/div[3]/a
    Input Text    //*[@id="ref"]    ${RefProduit}
    Input Text    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[2]/td[2]/input    P1
    Click Element    //*[@id="id-right"]/div/form/div[2]/table[2]/tbody/tr[1]/td[2]/input
    Input Text    //*[@id="id-right"]/div/form/div[2]/table[2]/tbody/tr[1]/td[2]/input    100
    #Click Element    //*[@id="mainbody"]/div[5]/div[3]/div[2]/a[1]
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Click Element    //*[@id="stock"]
    Click Element    //*[@id="id-right"]/div/div[3]/a[1]
    Input Text    //*[@id="nbpiece"]    ${StockPDT-01}
    Click Element    //*[@id="select2-id_entrepot-container"]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    01
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    # Pour verifier que le stock correspond a la valeur entrée.
    Element Should Contain    //*[@id="id-right"]/div/div[2]/div[3]/table/tbody/tr[8]/td[2]    ${StockPDT-01}

CT-SE-CreerStockProduit
    Click Element    //*[@id="mainmenutd_products"]/div/a[1]
    Click Element    //*[@id="id-left"]/div/div[4]/div[3]/a
    Input Text    //*[@id="id-right"]/div/form/div[2]/table[1]/tbody/tr[2]/td[2]/input    P1
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Page should contain    Le champ 'Réf.' est obligatoire

CT-SN-TransfererStock
    #Menu produit
    Click Element    //*[@id="mainmenutd_products"]/div/a[1]
    #Liste des produits
    Click Element    //*[@id="id-left"]/div/div[4]/div[4]/a
    #PDT-01
    Click Element    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[3]/td[1]/a
    #Onglet Stock
    Click Element    //*[@id="stock"]
    #Transferer Stock
    Click Element    //*[@id="id-right"]/div/div[3]/a[2]
    #Entrepot Source
    Click Element    //*[@id="select2-id_entrepot-container"]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ENT-001
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    #Entrepot Destination
    Click Element    //*[@id="select2-id_entrepot_destination-container"]
    Input Text    //*[@id="mainbody"]/span/span/span[1]/input    ENT-002
    Press Key    //*[@id="mainbody"]/span/span/span[1]/input    \\13
    #Nombre de pièces à tranferer.
    Input Text    //*[@id="id-right"]/div/form/div[2]/table/tbody/tr[2]/td[2]/input    30
    Click Element    //*[@id="id-right"]/div/form/div[3]/input[1]
    Page should contain    50
    Page should contain    30
    Page should contain    20

Deconnexion
    Sleep    5s
    Click Element    //*[@id="id-top"]/div[2]/div[2]/div[4]/div/a/span
