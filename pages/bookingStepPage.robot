*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
## Sample page object model for the booking site pages 
Click specialist booking button
    Click Button    xpath=//span[contains(text(),'Specialist Referral')]/..

Click phone call option
    Click Button    xpath=//div[@class = 'css-ndlu1i']

Select Dr Tom Kelly option
    Click Button    xpath=//div[@class = 'css-s3nan6']