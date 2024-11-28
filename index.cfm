<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap-5.0.2-dist/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>addressBook Login</title>
    </head>
    <body>
        <div class="header d-flex align-items-center p-2 d-flex">
            <div class="ms-5 me-2"><img src="assets/images/phone-book.png" alt="phoneBook" width="40">ADDRESS BOOK</div>
            <div class="signUp"><a href="signup.cfm"><img src="assets/images/user.png" alt="user">Sign Up</a></div>
            <div class="login"><a href="index.cfm"><img src="assets/images/login.png" alt="login">Login</a></div>
        </div>
        <div class="d-flex align-items-center justify-content-center loginMain">
            <div class="d-flex align-items-center justify-content-center left">
                <div>
                    <img src="assets/images/phone-book.png" alt="phoneBook" width="100">
                </div>
            </div>
            <div class="d-flex flex-column align-items-center right">
                <h3 class="loginText">LOGIN</h3>
                <form method="post" class="text-center">
                    <div><input class="userInputs px-4 mt-5" id="userName" name="userName" type="text" placeholder="Username"></div>
                    <div><input class="userInputs px-4 mt-5" id="pwd" name="password" type="password" placeholder="Password"></div>
                    <div><input class="loginButton bg-white mt-5" type="submit" name="submit" onclick="loginValidation()" value="LOGIN"></div>
                    <div class="signInText mt-2">Or Sign In Using</div>
                    <div class="d-flex justify-content-center mt-3">
                        <div><img src="assets/images/facebook.png" alt="facebookLogo" width="40"></div>
                        <div>
                            <a href="googleSignup.cfm" class="ms-2"><img src="assets/images/gmail.png" alt="gmailLogo" width="40"></a>
                        </div>
                    </div>
                </form>
                <div class="regLink mt-4">
                    Don't have an account? <a href="signup.cfm">Register Here</a>
                </div>
                <div id="error" class="mt-3"></div>
            </div>
        </div>
        <cfif structKeyExists(form, "submit")>
            <cfset local.value = createObject("component", "components.addressBook")>
            <cfset local.result = local.value.login(form.userName, form.password)>
            <cfif local.result=="true">
                <cflocation  url="home.cfm">
            <cfelse>
                <div class="d-flex justify-content-center">
                    <cfoutput>
                        #local.result#
                    </cfoutput>
                </div>
            </cfif>
        </cfif>
        <script src="js/script.js"></script>
    </body>
</html>