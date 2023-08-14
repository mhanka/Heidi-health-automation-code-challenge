*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
## Sample page object model for the booking site pages 
Click sign in Button
    Click Button  xpath=//button[contains(@class, 'MuiButton-textPrimary') and contains(text(), 'Sign in')]
 
Click Create account Button
     Click Button  xpath=//button[contains(@class, 'MuiButton-textPrimary') and contains(text(), 'Create Account')]
     [Return]    xpath=//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci'] 

 Add medical condition button
     [Return]    xpath=//div[@class='css-175oi2r r-1i6wzkk r-lrvibr r-1loqt21 r-1otgn73 r-10paoce r-1awozwy r-18u37iz r-1777fci']

Input medical condition button
    [Return]    xpath=//body/div[@id='__next']/div[1]/div[1]/div[1]/div[2]/div[2]/div[2]/div[2]/div[1]/div[3]/div[1]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[3]/div[1]/div[1]/input[1]         