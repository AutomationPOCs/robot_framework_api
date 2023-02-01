*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}=  https://reqres.in
${request_url}=      /api/users


*** Test Cases ***
Post_Request
        Create Session    mysession     ${base_url}
        ${body}=    create dictionary       name=morpheus    job=leader
#        mention the format of data that server accept
        ${header}=      create dictionary    Content-Type=charset=utf-8
        ${response}=    post on session     mysession   ${request_url}      data=${body}    headers=${header}

#   validations
        ${status_code}=     convert to string    ${response.status_code}
        should be equal    ${status_code}   201

        ${res_body}=    convert to string    ${response.content}
        log to console    ${res_body}
        should contain    ${res_body}       id

