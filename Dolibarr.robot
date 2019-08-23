*** Settings ***
Library           SeleniumLibrary

*** Variables ***
@{username}       Aline    Anna    Loc
@{pwd}            123    123    123

*** Test Cases ***
Connexion
    Open browser    http://localhost/dolibarr/    chrome
    Location Should Be    http://localhost/dolibarr/
    Click Element    xpath=//*[@id="username"]
    Input Text    xpath=//*[@id="username"]    @{username}[0]
    Textfield Value Should Be    xpath=//*[@id="username"]    @{username}[0]
    Click Element    xpath=//*[@id="password"]
    Input Password    xpath=//*[@id="password"]    123
    Click Button    xpath=//*[@id="login_line2"]/input
    Location Should Be    http://localhost/dolibarr/admin/index.php?mainmenu=home&leftmenu=setup&mesg=setupnotcomplete
    Click Element    xpath=//*[@id="topmenu-login-dropdown"]/a/img
    Click Element    xpath=//*[@id="topmenu-login-dropdown"]/div/div[3]/div[2]/a
    Element Should Be Visible    xpath=//*[@id="login_line2"]/input

ConnexionDataDriven
    [Tags]    Data    3
    [Setup]    Open browser    http://localhost/dolibarr/    chrome
    [Template]    Connec
    @{username}[0]
    @{username}[1]
    @{username}[2]
    [Teardown]    Close All Browsers

ConnexionBoucle
    [Tags]    Data
    Open browser    http://localhost/dolibarr/    chrome
    :FOR    ${ELEMENT}    IN    @{username}
    \    Log    ${ELEMENT}
    \    Connec    ${ELEMENT}
    Close All Browsers

*** Keywords ***
Connec
    [Arguments]    @{username}
    [Tags]    Data    3
    Click Element    //*[@id="username"]
    Input Text    //*[@id="username"]    @{username}
    Textfield Value Should Be    //*[@id="username"]    @{username}
    Click Element    //*[@id="password"]
    Input Password    //*[@id="password"]    123
    Click Button    //*[@id="login_line2"]/input
    Location Should Be    http://localhost/dolibarr/admin/index.php?mainmenu=home&leftmenu=setup&mesg=setupnotcomplete
    Click Element    xpath=//*[@id="topmenu-login-dropdown"]/a/img
    Click Element    xpath=//*[@id="topmenu-login-dropdown"]/div/div[3]/div[2]/a
    Element Should Be Visible    xpath=//*[@id="login_line2"]/input
