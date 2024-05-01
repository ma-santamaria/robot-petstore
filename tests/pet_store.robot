*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../libraries/data_parser.py

*** Variables ***
${base_url}    https://petstore.swagger.io/v2

*** Test Cases ***
Create a new user and then recover its data
    ${secs}    Get Time    epoch
    ${newUserName}    Set Variable    newUser-${secs}
    ${body}    Create Dictionary    id=0    username=${newUserName}    firstName=New    lastName=User    email=new.user@example.com    password=password    phone=555123456    userStatus=0
    ${response}    POST    url=${base_url}/user    json=${body}
    Status Should Be    200
    ${id}    Set Variable    ${response.json()}[message]
    ${response}    GET    ${base_url}/user/${newUserName}
    Status Should Be    200

Find all sold pets and print the totals by name
    ${params} =    Create Dictionary    status=sold
    ${response}    GET    ${base_url}/pet/findByStatus    params=${params}
    Status Should Be    200
    @{PetNames}=    Create List
    FOR  ${pet}  IN  @{response.json()}
        Append To List    ${PetNames}    ${pet}[name]
    END
    Log    ${PetNames}
    ${totals}    Get Total By Name    ${PetNames}
    Log    ${totals}
