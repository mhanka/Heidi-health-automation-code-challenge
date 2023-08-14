*** Settings ***
Library           SeleniumLibrary    timeout=10
Library     random
Library    String
Library    FakerLibrary
Test Teardown     Close Browser
*** Variables ***
${BROWSER}    Firefox
${URL}    https://registrar.care.heidihealth.com.au/clinic/heidi-test-clinic
${SLEEP}    3

*** Test Cases ***
New patient workflow appointment booking Test
    Create Webdriver    ${BROWSER}
    [Documentation]    This test case registers a new patient and makes a specialist appointment via phone call and validates the appointment details
    ## Reset the state of the website before running the test
    Delete All Cookies
    Go To    ${URL}
    Maximize Browser Window
    Sleep    5s    
    ## Select 'Create account' option and register the account using Mobile number and email id
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-fkpebx"]
    ## Create a random phone number which satifies the phone format
    ${remaining_digits}    Generate random string        6     0123456789
    ${random_phone_number}    Set Variable    450${remaining_digits}
    Input Text    //input[@class="MuiInputBase-input MuiInputBase-inputAdornedStart css-mnn31"]    ${random_phone_number}
    Sleep    2s
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    3s
    ## Extract OTP content from notification and input it
    ${mobile_otp_message_content}    Get Text    //span[@class="css-1u8pghy"]
    ${text_parts}    Split String    ${mobile_otp_message_content}    ${SPACE}
    ${last_item}    Set Variable    ${text_parts[-1]}
    ${last_item_variable}    Set Variable    ${last_item}
    @{mobile_otp_content}    Split String     ${last_item_variable}    ''        
    Sleep    1s
    Input Text    //*[@data-id="0"]    ${mobile_otp_content}[0]
    Sleep    3s
    ## Create a random email id using Faker which satifies the email fomrmat and set the account email id as a global variable
    ${random_word}    FakerLibrary.word
    ${random_email}    Set Variable    ${random_word}@example.com
    Set Global Variable    $account_email    ${random_email}
    Input Text    //input[@class="MuiInputBase-input css-mnn31"]    ${random_email}
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    3s
    Wait Until Element Is Visible    //span[@class="css-1u8pghy"]    
    ${email_otp_message_content}    Get Text    //span[@class="css-1u8pghy"]
    ${text_parts}    Split String    ${email_otp_message_content}    ${SPACE}
    ${last_item}    Set Variable    ${text_parts[-1]}
    ${last_item_variable}    Set Variable    ${last_item}
    @{email_otp_content}    Split String     ${last_item_variable}    ''        
    Sleep    1s
    Input Text    //*[@data-id="0"]    ${email_otp_content}[0]
    Sleep    3s
    ## Validate the registeration is successful or not
    Element Should Contain    //span[contains(text(),'We can help you book appointments, complete pre-ap')]    We can help you book appointments, complete pre-appointment checks or store your medical history.
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    5s
    ## Select Specialist referal option and select phone appointment option
    Wait Until Element Is Visible    //span[contains(text(),'Specialist Referral')]
    Click Element    //span[contains(text(),'Specialist Referral')]
    Wait Until Element Is Visible    //span[@class="css-50hk7d"]
    Click Element    //span[@class="css-50hk7d"]
    ## Select Dr Tom Kelly option 
    Wait Until Element Is Visible    //div[@class="css-102wlwf"]
    Click Element    //div[@class="css-102wlwf"]
    Wait Until Element Is Visible    //span[@class="css-1l43ly2"]
    Click Element    //span[@class="css-1l43ly2"]
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    ## Fill patient profile details and confirm appointment
    Wait Until Element Is Visible    //input[@class="MuiInputBase-input css-mnn31"]
    Input Text    //input[@class="MuiInputBase-input css-mnn31"]    Steve
    Click Element    xpath=(//input[@class="MuiInputBase-input css-mnn31"])[3] 
    Input Text    xpath=(//input[@class="MuiInputBase-input css-mnn31"])[3]    Martin
    Click Element    //input[@class="css-cp6m3d"]
    Wait Until Element Is Visible    xpath=//button[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeSmall MuiPickersCalendarHeader-switchViewButton css-1wjkg3"]
    Click Element    xpath=//button[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeSmall MuiPickersCalendarHeader-switchViewButton css-1wjkg3"]
    Wait Until Element Is Visible    xpath=(//button[@class="PrivatePickersYear-yearButton css-m1gykc"])[101]
    Click Element    xpath=(//button[@class="PrivatePickersYear-yearButton css-m1gykc"])[101]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'MuiButtonBase-root MuiPickersDay-root MuiPickersDay-dayWithMargin css-ub1r1') and contains(text(), '12')]
    Click Element    xpath=//button[contains(@class, 'MuiButtonBase-root MuiPickersDay-root MuiPickersDay-dayWithMargin css-ub1r1') and contains(text(), '12')]
    Sleep    2s
    Click Element    (//input[@placeholder="Please select"])[1]
    Wait Until Element Is Visible    xpath=(//div[@class="css-tzll1h"])[2]
    Click Element    xpath=(//div[@class="css-tzll1h"])[2]
    Input Text    //input[@class="MuiInputBase-input MuiInputBase-inputAdornedStart css-mnn31"]    11 york
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    10s
    Wait Until Element Is Visible    //div[@class="css-dfgznq"]
    Click Element    //div[@class="css-dfgznq"]
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    5s
    ## Validate the appointment details such as price and confirmation
    Element Should Contain    //span[@class='css-nlhtmg']    96.36
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    3s
    Element Should Contain    //div[@class='css-1hwp0ek']    Your appointment is confirmed!

Existing Patient annual checkup workflow
    Create Webdriver    ${BROWSER}
    [Documentation]    This test case allows an existing patient to perform an annual checkup with pre-existing medical condition with Dr Tom Kelly
    Delete All Cookies
    Go To    ${URL}
    Maximize Browser Window
    Sleep    5s
    ## Existing patient performs login using email id and inputs the email otp
    Click Button    //button[@class='MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y']
    Wait Until Element Is Visible    //span[contains(text(),'Sign in with email instead')]
    Click Element    //span[contains(text(),'Sign in with email instead')]
    ${account_email}    Get Variable Value    $account_email
    Input Text    //input[@class="MuiInputBase-input css-mnn31"]    ${account_email}
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    3s
    Wait Until Element Is Visible    //span[@class="css-1u8pghy"]    
    ${account_email_otp_message_content}    Get Text    //span[@class="css-1u8pghy"]
    ${text_parts}    Split String    ${account_email_otp_message_content}    ${SPACE}
    ${last_item}    Set Variable    ${text_parts[-1]}
    ${last_item_variable}    Set Variable    ${last_item}
    @{account_email_otp_content}    Split String     ${last_item_variable}    ''        
    Sleep    1s
    Input Text    //*[@data-id="0"]    ${account_email_otp_content}[0]
    Sleep    3s
    ## Validation to check whether login is successful or not
    Element Should Contain    //span[contains(text(),'We can help you book appointments, complete pre-ap')]    We can help you book appointments, complete pre-appointment checks or store your medical history.
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    5s
    ## Select specialist referral option and select Dr Tom Kelly as doctor
    Wait Until Element Is Visible    //span[contains(text(),'Specialist Referral')]
    Click Element    //span[contains(text(),'Specialist Referral')]
    Sleep    3s
    Wait Until Element Is Visible    //span[@class="css-1l43ly2"]
    Click Element    //span[@class="css-1l43ly2"]
    Click Element    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Sleep    5s
    Element Should Contain    //button[@class='MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y']    30.60
    ## Add Credit card payment details and store it for later and perform the payment
    Wait Until Element Is Visible    //div[contains(text(),'Add payment method')]
    Click Element    //div[contains(text(),'Add payment method')]
    Wait Until Element Is Visible    //div[@class='ReadOnlyFormField-title']
    Element Should Contain    //div[@class='ReadOnlyFormField-title']    ${account_email}
    Input Text    //input[@id='cardNumber']    4242424242424242
    Input Text    //input[@id='cardExpiry']    11/24
    Input Text    //input[@id='cardCvc']    123
    Input Text    //input[@id='billingName']    Steve
    Sleep    3s
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    1s
    Click Button    //button[@class='SubmitButton SubmitButton--complete']
    Sleep    10s
    Wait Until Element Is Visible     //button[@class='MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y']
    Click Button     //button[@class='MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y']
    Wait Until Element Is Visible        //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    Click Button    //button[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-vst21y"]
    ## Validate to check appointment is confirmed or not
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[2]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[2]
    # Provide medical condition history which includes Acute Diarrhoea
    Wait Until Element Is Visible    //div[contains(text(),'Yes')]
    Click Element    //div[contains(text(),'Yes')]
    Wait Until Element Is Visible    //div[contains(text(),'Add condition')]
    Click Element    //div[contains(text(),'Add condition')]
    Wait Until Element Is Visible    //input[@class="css-11aywtz r-6taxm2 r-1mlwlqe r-16y2uox r-1wbh5a2 r-10paoce"]
    Click Element    //input[@class="css-11aywtz r-6taxm2 r-1mlwlqe r-16y2uox r-1wbh5a2 r-10paoce"]
    Input Text    //input[@class="css-11aywtz r-6taxm2 r-1mlwlqe r-16y2uox r-1wbh5a2 r-10paoce"]    Acute diarrhoea
    Sleep    5s
    Wait Until Element Is Visible    (//div[@class='css-1rynq56 r-fdjqy7' and contains(text(),'Acute diarrhoea')])
    Click Element    (//div[@class='css-1rynq56 r-fdjqy7' and contains(text(),'Acute diarrhoea')])
    Wait Until Element Is Visible    //div[contains(text(),'Next')]
    Click Element    //div[contains(text(),'Next')]
    ## Provide medical, lifestyle, reproductive and other information by selecting the appropriate option
    Wait Until Element Is Visible    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[7]
    Click Element    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[7]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[9]
    Click Element    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[9]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[11]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[11]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[13]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[13]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[17]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[17]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[21]    
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[21]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[24]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[24]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[26]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[26]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[30]
    Click Element    xpath=(//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[30]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[30]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[30]
    Sleep    1s
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[30]
    Sleep    2s
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[30]
    Sleep    2s
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[29]
    Sleep    2s
    ## Book for annual check up for Acute Diarrohea with Dr Tom Kelly and select Referral date of 30/09/2023
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[2]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[2]
    Wait Until Element Is Visible     xpath=(//input[@placeholder="Select specialty"])
    Input Text    xpath=(//input[@placeholder="Select specialty"])    General Prac
    Sleep    1s
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-1awozwy r-18u37iz r-10paoce"])[2]
    Input Text    xpath=(//input[@placeholder="Enter name"])    Dr Tom Kelly
    Sleep    1s
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[10]
    Sleep    1s
    Input Text    //textarea[@placeholder='Enter your text']    Annual checkup
    Sleep    1s
    Wait Until Element Is Visible    (//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[10]
    Click Element    (//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[10]
    Sleep    1s
    Wait Until Element Is Visible    //div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-1awozwy r-18u37iz"]
    Click Element    //div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-1awozwy r-18u37iz"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[12]
    Click Element    xpath=(//div[@class="css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci"])[12]
    Sleep    2s
    Wait Until Element Is Visible     //div[@class='css-1rynq56' and contains(text(),'30')]
    Click Element    //div[@class='css-1rynq56' and contains(text(),'30')]
    Wait Until Element Is Visible    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Click Element    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Sleep    1s
    ## Confirm appointment for annual checkup and validate the details
    Wait Until Element Is Visible    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Click Element    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Sleep    1s
    Wait Until Element Is Visible    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Click Element    (//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'])[10]
    Wait Until Element Is Visible    //div[contains(text(),'You’re all finished!')]
    Element Should Contain    //div[contains(text(),'You’re all finished!')]    You’re all finished!

    