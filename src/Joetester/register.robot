*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${URL}                https://uat.potioneer.com/
${Url_gmail}          https://www.google.com/intl/th/gmail/about/
${Browser}            chrome
${Email}              jratchatathiwat69@gmail.com
${Password}           12345679
${Password_gmail}     test12345679
${Verify_now_mail}    Verify now

#x-path
${Accept_cookies}              xpath=//html/body/div[1]/div/div[2]/div/div/div/div[2]/button
${Close_modal}                 xpath=//html/body/div[8]/div[3]/div/button
${Close_modal_ver_mail}        xpath=//html/body/div[3]/div[3]/div/button
${Icon_profile}                xpath=//html/body/div[1]/div/div[1]/header/div[1]/div/div/div[2]/div[2]
${Button_logout}               xpath=//html/body/div[9]/div[3]/button
${Close_popup_register}        xpath=//html/body/div[3]/div[3]/div/button
${Button_sign_up}              xpath=//html/body/div[3]/div[3]/div/div/form/div[2]/div[2]/div/span/span
${Button_register}             xpath=//html/body/div[3]/div[3]/div/div/form/button
${Check_box_aeree}             xpath=//html/body/div[3]/div[3]/div/div/form/div[2]/label/span/input
${Button_sign_in_gmail}        xpath=//html/body/header/div/div/div/a[2]
${Button_next__id_gmail}       xpath=//html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[2]/div/div[1]/div/div/button
${Button_next__pass_gmail}     xpath=//html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[2]/div/div[1]/div/div/button
${Input_password_gmail}        xpath=//html/body/div[1]/div[1]/div[2]/div/c-wiz/div/div[2]/div/div[1]/div/form/span/section[2]/div/div/div[1]/div[1]/div/div/div/div/div[1]/div/div[1]/input
${Button_explore_potioneer}    xpath=//html/body/div[1]/div/div[1]/main/div/div/div/div/a
${Li_account}                  xpath=//html/body/div[9]/div[3]/div[2]/li[1]
${Delete_account}              xpath=//html/body/div[1]/div/div/main/div[2]/div[2]/div/form/div/div[2]/div[4]/div[2]/div

#Time
${Time_2s}    2

# helping text
${Required_input_first_name}    first name is a required field
${Required_input_last_name}     last name is a required field
${Required_input_text}          Please enter the required fields.
${Required_checkbox_i_agree}    Please agree the terms and conditions before register.



*** Keywords ***
@open_browser
    Open Browser               about:blank    ${Browser}
    Maximize Browser Window
    Go to                      ${url}

@accept_cookie
    Set Selenium Implicit Wait    3s
    Click Element                 ${Accept_cookies}

@close_popup
    Click Element    ${Close_modal}

@close_popup_register
    Click Element    ${Close_popup_register}

@close_popup_success_register
    Set Selenium Implicti Wait    3s
    Click Element                 ${Close_modal_ver_mail}
    sleep                         5s

@wait_until_all_close
    Wait Until Element Is Visible    ${Icon_profile}    ${Time_2s}

@click_icon_profile
    @wait_until_all_close
    Press Keys               ${Icon_profile}    enter

@click_button_sign_up
    Set Selenium Implicit Wait    ${Time_2s}
    Click Element                 ${Button_sign_up}

@click_button_register
    Click Button    ${Button_register}

@go_to_gmail_and_sign_in
    Go to                         ${Url_gmail}
    Set Selenium Implicit Wait    5s
    Click Element                 ${Button_sign_in_gmail}
    Input Text                    id=identifierId            ${Email}
    Click Element                 ${Button_next_id_gmail}
    Set Selenium Implicit Wait    10s
    Input Password                ${Input_password_gmail}    ${Password_gmail}
    Click Element                 id=passwordNext

@verify_mail_go_to_potioneer
    Click Element                    xpath=(//table[@class="F cf zt"]/tbody/tr)[1]
    Set Selenium Implicit Wait       5s
    Press Keys                       ${Verify_now_mail}                               enter
    Wait Until New Window Is Open    timeout=10s
    Switch Window                    index=1
    Title Should Be                  Potioneer
    Click Button                     ${Button_explore_potioneer}
    sleep                            5s

@delete_account_potioneer
    Click Element                 ${Icon_profile}
    Set Selenium Implicit Wait    ${Time_2s}
    Click Element                 ${Li_account}
    Set Selenium Implicit Wait    5s
    Click Element                 ${Delete_account_potioneer}


*** Test Cases ***
Open Browser go to web Potioneer
    @open_browser
    @accept_cookie
    @close_popup

Open the profile icon and go to the registration page
    @click_icon_profile
    @click_button_sign_up
    @click_button_register
    Wait Until Page Contains    ${Required_input_first_name}    ${Time_2s} 
    Wait Until Page Contains    ${Required_input_last_name}     ${Time_2s}
    Wait Until Page Contains    ${Required_input_text}          ${Time_2s}
    Wait Until Page Contains    ${Required_checkbox_i_agree}    ${Time_2s}
    @close_popup_register

Happy case register
    @click_icon_profile
    @click_button_sign_up
    Input Text                       id=first_name         First
    Input Text                       id=last_name          Full
    Input Text                       id=email              ${Email}
    Input Password                   id=password           ${Password}
    Click Element                    ${Check_box_aeree}
    @click_button_register
    @close_popup_success_register

Go to sing in gmail
    @go_to_gmail_and_sign_in
    @verify_mail_go_to_potioneer