*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${URL}         https://uat.potioneer.com/
${Browser}     chrome
${Email}       jratchatathiwat69@gmail.com
${Password}    12345679

#x-path
${Accept_cookies}          xpath=//html/body/div[1]/div/div[2]/div/div/div/div[2]/button
${Close_modal}             xpath=//html/body/div[8]/div[3]/div/button
${Icon_profile}            xpath=//html/body/div[1]/div/div[1]/header/div[1]/div/div/div[2]/div[2]
${Button_logout}           xpath=//html/body/div[9]/div[3]/button
${Close_popup_register}    xpath=//html/body/div[3]/div[3]/div/button
${Button_sign_up}          xpath=//html/body/div[3]/div[3]/div/div/form/div[2]/div[2]/div/span/span
${Button_register}         xpath=//html/body/div[3]/div[3]/div/div/form/button
${Check_box_aeree}         xpath=//html/body/div[3]/div[3]/div/div/form/div[2]/label/span/input

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
    Click Element    ${Accept_cookies}

@close_popup
    Click Element    ${Close_modal}

@close_popup_register
    Click Element    ${Close_popup_register}

@wait_until_all_close
    Wait Until Element Is Visible    ${Icon_profile}    ${Time_2s}

@click_icon_profile
    @wait_until_all_close
    Press Keys               ${Icon_profile}    enter

@click_button_sign_up
    Click Element    ${Button_sign_up}

@click_button_register
    Click Button    ${Button_register}



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
    Input Text               id=first_name         First
    Input Text               id=last_name          Full
    Input Text               id=email              ${Email}
    Input Password           id=password           ${Password}
    Click Element            ${Check_box_aeree}
    sleep                    2s
