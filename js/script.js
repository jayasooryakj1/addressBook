if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
}

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

function modalValidation() {
    var title = document.getElementById("title").value;
    var fname = document.getElementById("fname").value;
    var lname = document.getElementById("lname").value;
    var gender = document.getElementById("gender").value;
    var dob = document.getElementById("dob").value;
    var address = document.getElementById("address").value;
    var street = document.getElementById("street").value;
    var district = document.getElementById("district").value;
    var state = document.getElementById("state").value;
    var country = document.getElementById("country").value;
    var pincode = document.getElementById("pincode").value;
    var email = document.getElementById("email").value;
    var phoneNumber = document.getElementById("phoneNumber").value;
    if(title==""||fname==""||lname==""||gender==""||dob==""||address==""||street==""||district==""||state==""||country==""||pincode==""||email==""||phoneNumber==""){
        document.getElementById("modalError").innerHTML="*Enter all the fields*"
        document.getElementById("modalError").style.color="red"
        event.preventDefault();
    }
    else if(pincode.length!=6|| isNaN(pincode)){
        document.getElementById("modalError").innerHTML="Invalid pincode"
        document.getElementById("modalError").style.color="red"
        event.preventDefault();
    }
    else if(phoneNumber.length!=10|| isNaN(phoneNumber)){
        document.getElementById("modalError").innerHTML="Invalid phone number"
        document.getElementById("modalError").style.color="red"
        event.preventDefault();
    }
}

function createContact(){
    document.getElementById("modalHeadingChange").innerHTML="CREATE CONTACT"
}