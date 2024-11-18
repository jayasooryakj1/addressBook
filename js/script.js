function signupValidation(event) {
    var fullName =  document.getElementById("fullName").value;
    var email =  document.getElementById("email").value;
    var userName =  document.getElementById("userName").value;
    var pwd =  document.getElementById("pwd").value;
    var cfPwd =  document.getElementById("cfPwd").value;
    let whiteSpace = new Set([" ", "\t", "\n"]);
    
    for(let i = 0;i<userName.length; i++){
        if(whiteSpace.has(userName[i])){
            document.getElementById("error").innerHTML="User Name cannot have space in it"
            event.preventDefault();
        }
    }

    if(fullName==""||email==""||userName==""||pwd==""||cfPwd==""){
        document.getElementById("error").innerHTML="Enter all the fields"
        event.preventDefault();
    }
    else if(pwd!=cfPwd){
        document.getElementById("error").innerHTML="Password mismatch"
        event.preventDefault();
    }
    else if(pwd.length<8){
        document.getElementById("error").innerHTML="Password must be minimum 8 characters long"
        event.preventDefault();
    }
}

function loginValidation() {
    var userName =  document.getElementById("userName").value;
    var pwd =  document.getElementById("pwd").value;
    if((userName == "")||(pwd == "")){
        document.getElementById("error").innerHTML="Enter both user name and password"
        event.preventDefault();
    }
}