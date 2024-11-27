<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../bootstrap-5.0.2-dist/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>signUp</title>
    </head>
    <body>
        <div class="header d-flex align-items-center p-2 d-flex">
            <div class="ms-5 me-2"><img src="assets/images/phone-book.png" alt="phoneBook" width="40">ADDRESS BOOK</div>
            <div class="signUp"><a href="signup.cfm"><img src="assets/images/user.png" alt="user">Sign Up</a></div>
            <div class="login"><a href="index.cfm"><img src="assets/images/login.png" alt="login">Login</a></div>
        </div>
        <div class="d-flex align-items-center justify-content-center signupMain">
            <div class="d-flex align-items-center justify-content-center leftSign">
                <div>
                    <img src="assets/images/phone-book.png" alt="phoneBook" width="100">
                </div>
            </div>
            <div class="d-flex flex-column align-items-center rightSign">
                <h3 class="loginText">SIGN UP</h3>
                <form class="text-center" method="post" enctype="multipart/form-data">
                    <div><input name="fullName" class="userInputs px-4 mt-2" type="text" id="fullName" placeholder="Full Name"></div>
                    <div id="errorName" class="red"></div>
                    <div><input name="email" class="userInputs px-4 mt-5" type="email" id="email" placeholder="Email ID"></div>
                    <div id="errorEmail" class="red"></div>
                    <div><input name="userName" class="userInputs px-4 mt-5" type="text" id="userName" placeholder="Username"></div>
                    <div id="errorUserName" class="red"></div>
                    <div><input name="userImage" class="px-4 mt-5" id="userImage" type="file"></div>
                    <div><input name="password" class="userInputs px-4 mt-5" type="password" id="pwd" placeholder="Password"></div>
                    <div id="errorPwd" class="red"></div>
                    <div><input name="cfPassword" class="userInputs px-4 mt-5" type="password" id="cfPwd" placeholder="Confirm Password"></div>
                    <div id="errorPwd2" class="red"></div>
                    <div><input name="submit" class="mt-3 register" type="submit" value="REGISTER" onclick="signupValidation(event)"></div>
                </form>
                <div id="error" class="red"></div>
                <cfset local.uploadLocation = "./assets/imageUploads/">
                <cfif structKeyExists(form, "submit")>
                    <cfif structKeyExists(form, "userImage") AND len(form.userImage)>
                        <cffile action="upload"
                            filefield="form.userImage"
                            destination="#expandPath(local.uploadLocation)#"
                            nameconflict="makeunique"
                            result="fileName">
                        <cfset local.value = createObject("component", "components.addressBook")>
                        <cfset local.result = local.value.signup(form.fullName, form.email, form.userName, fileName.serverfile, form.password)>
                    <cfelse>
                        <cfset local.value = createObject("component", "components.addressBook")>
                        <cfset local.result = local.value.signup(form.fullName, form.email, form.userName, "/userDefault.jpg", form.password)>
                    </cfif>
                    <div class="mt-2">
                        <cfoutput>
                            #local.result#
                        </cfoutput>
                    </div>
                </cfif>
            </div>
        </div>
        <script src="js/script.js"></script>
    </body>
</html>