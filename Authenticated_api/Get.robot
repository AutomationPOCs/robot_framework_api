*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
*** Variables ***
${Base_url}     https://musicapi13.p.rapidapi.com
${parameter1}   /search/introspection

*** Test Cases ***
Authenticated_get_request
        [Documentation]    This test case verifies that the response code of thr GET Request should be 200
        ...    The response body contain 'source' key with value [ amazon-music , apple-music , deezer ,pandora ,sound-cloud ,spotify ]
        ...    and the response body contains 'type' Key with value [ track,album]

        [Tags]    smoke
        Create Session    mysession   ${Base_url}   verify=true
        ${header}=      create dictionary    Content-Type=application/json   charset=utf-8   X-RapidAPI-Key=1e439c0166msh465d2a9ddc44c59p1a2ab2jsn83310a682d75    X-RapidAPI-Host=musicapi13.p.rapidapi.com
        ${response}=    GET On Session    mysession    ${parameter1}     headers=${header}
#        log to console      ${response}

#        VALIDATION
        ${status_code}=    convert to string    ${response.status_code}
         should be equal    ${status_code}      200

        ${response_body}=     ${response.content}
#        converting response body into the JSON Format
        ${response_dict}=    Evaluate    json.loads(response.content)
        log to console    ${response_dict}

#        log to console      ${response_body}
        should contain      ${response_body}    spotify

#extracting particular key value
        ${extracted_data} =   get value from json    ${response.json()}[0]    sources
        log to console   ${extracted_data}

