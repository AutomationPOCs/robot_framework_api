*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}     https://reqres.in
${parameter1}       /api/users?page=2
*** Test Cases ***
get_requests
        Create Session    mysession     ${base_url}
        ${response}=    GET On Session    mysession   ${parameter1}

#        log to console    ${response.status_code}
#        log to console    ${response.content}
#        log to console    ${response.headers}

#VALIDATIONS
         ${status_code}=    convert to string    ${response.status_code}
         should be equal    ${status_code}      200

         ${body}=  convert to string    ${response.content}
         should contain    ${body}      Michael

#extracting the value of key by using collections library
        ${content_type_value}=    get from dictionary    ${response.headers}     Content-type
        should be equal    ${content_type_value}    application/json
            log to console    ${content_type_value}



