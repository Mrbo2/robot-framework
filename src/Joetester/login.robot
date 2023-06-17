*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${URL}         https://uat.potioneer.com/
${Browser}     chrome
${Username}    jojoe090341@gmail.com
${Password}    12345679

#Account email
${Email_username}    suchaoinkanoknan55@gmail.com
${Email_password}    test12345679


#x-path
${Accept_cookies}         xpath=//html/body/div[1]/div/div[2]/div/div/div/div[2]/button
${Close_modal}            xpath=//html/body/div[8]/div[3]/div/button
${Icon_profile}           xpath=//html/body/div[1]/div/div[1]/header/div[1]/div/div/div[2]/div[2]
${Online_icon_profile}    xpath=//html/body/div[1]/div/div/header/div[1]/div/div/div[2]/div[3]
${Button_login}           xpath=//html/body/div[3]/div[3]/div/div/form/button 
${Button_logout}          xpath=//html/body/div[9]/div[3]/button
${Close_popup_login}      xpath=//html/body/div[3]/div[3]/div/button
${Button_email}           xpath=//html/body/div[3]/div[3]/div/div/div[3]/div[1]

#Time
${Time_2s}    2

# helping text
${Required_input_text}           Please enter the required fields.
${User_put_wrong_information}    Email address or password is either incorrect or not register with Potioneer


*** Keywords ***
@open_browser
    Open Browser               about:blank    ${Browser}
    Maximize Browser Window
    Go to                      ${url}

@accept_cookie
    Click Element    ${Accept_cookies}

@close_popup
    Click Element    ${Close_modal}

@close_popup_login
    Click Element    ${Close_popup_login}

@wait_until_all_close
    Wait Until Element Is Visible    ${Icon_profile}    ${Time_2s}

@open_popup_login
    @wait_until_all_close
    Press Keys               ${Icon_profile}    enter

@wait_open_icon_profile
    Wait Until Element Is Visible    ${Online_icon_profile}    ${Time_2s}

@open_icon_profile
    @wait_open_icon_profile
    Press Keys                 ${Online_icon_profile}    enter

@open_button_email
    Click Element    ${Button_email}

@click_button_login
    Set Selenium Implicit Wait    ${Time_2s}
    Click Button                  ${Button_login}

@click_button_logout
    Click Button    ${Button_logout}



*** Test Cases ***
Open Browser go to web Potioneer
    @open_browser
    @accept_cookie
    @close_popup

Click icon profile and buttom login
    @open_popup_login
    @click_button_login
    Wait Until Page Contains    ${Required_input_text}    ${Time_2s} 
    @close_popup_login

User entered wrong password
    @open_popup_login
    Input Text                  id=email                         ${Username}
    Input Password              id=password                      123456789
    @click_button_login
    Wait Until Page Contains    ${User_put_wrong_information}    ${Time_2s} 
    @close_popup_login

Happy case singin
    @open_popup_login
    Input Text              id=email       ${Username}
    Input Password          id=password    ${Password}
    @click_button_login
    sleep                   2s
    @open_icon_profile
    @click_button_logout
    sleep                   1s
    Close Browser