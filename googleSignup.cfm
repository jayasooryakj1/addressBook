<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Signup</title>
</head>
<body>
    <cflogin>
        <cfoauth
            type = "Google"
            clientid = ""
            secretkey = ""
            result = "result"
            redirecturi = ""
            scope="email"
        >
        <cfif isDefined("result")>
            <cfset googleObj = createObject("component", "components.addressBook")>
            <cfset googleResult = googleObj.googleLogin(result)>
        </cfif>
    </cflogin>
</body>
</html>