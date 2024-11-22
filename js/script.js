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
    document.getElementById("modalError").innerHTML=""
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
    var contactId = document.getElementById("contactIdHidden").value;
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
    $.ajax({
        type:"POST",
        url:"./components/addressBook.cfc?method=emailExist",
        data:{existentEmail:email, existentNumber:phoneNumber, contactId:contactId},
        success:function(result){
            if(result){
                alert("Email or phone number already exists")
                document.getElementById("submit").type="button"
                event.preventDefault()
            }
            else{
                document.getElementById("submit").type="submit"
            }
        }
    })
}

function createContact(){
    document.getElementById("modalHeadingChange").innerHTML="CREATE CONTACT"
    document.getElementById("contactForm").reset()
    document.getElementById("contactCreationImage").src="assets/imageUploads/userDefault.jpg"
    document.getElementById("submit").name="create"
}

function deleteContact(dltObj){
    if(confirm("Delete contact?")){
        $.ajax({
            type:"post",
            url:"components/addressBook.cfc?method=deleteFunction",
            data:{dlt:dltObj.value},
            success:function(result){
                if(result){
                    location.reload();
                }
            }
        })
    }
}

function viewContact(viewId)
{
    $.ajax({
        type:"POST",
        url:"./components/addressBook.cfc?method=viewContact",
        data:{viewId:viewId.value},
        success: function(result) {
            var resultStruct=JSON.parse(result);
            document.getElementById("detailsName").innerHTML=resultStruct.name
            document.getElementById("detailsGender").innerHTML=resultStruct.gender
            document.getElementById("detailsDob").innerHTML=resultStruct.dob
            document.getElementById("contactProfilePic").src=resultStruct.photo
            document.getElementById("detailsAddress").innerHTML=resultStruct.address
            document.getElementById("detailsPincode").innerHTML=resultStruct.pincode
            document.getElementById("detailsEmail").innerHTML=resultStruct.email
            document.getElementById("detailsPhone").innerHTML=resultStruct.phn
        }
    });
}

function editContact(editId)
{
    document.getElementById("contactForm").reset()
    var editContactId= document.getElementById("editButton").value
    document.getElementById("submit").name="edit"
    document.getElementById("modalHeadingChange").innerHTML="EDIT CONTACT"
    $.ajax({
        type:"POST",
        url:"./Components/addressBook.cfc?method=editContact",
        data:{editId:editId.value},
        success: function(result) {
            var resultStruct=JSON.parse(result);
            document.getElementById("contactIdHidden").value=resultStruct.contactId
            document.getElementById("title").value=resultStruct.title
            document.getElementById("fname").value=resultStruct.fname
            document.getElementById("lname").value=resultStruct.lname
            document.getElementById("gender").value=resultStruct.gender
            document.getElementById("dob").value=resultStruct.dob
            document.getElementById("contactCreationImage").src=resultStruct.photo
            document.getElementById("imgHidden").value=resultStruct.photo
            document.getElementById("address").value=resultStruct.address
            document.getElementById("street").value=resultStruct.street
            document.getElementById("district").value=resultStruct.district
            document.getElementById("state").value=resultStruct.state
            document.getElementById("country").value=resultStruct.country
            document.getElementById("pincode").value=resultStruct.pincode
            document.getElementById("email").value=resultStruct.email
            document.getElementById("phoneNumber").value=resultStruct.phoneNumber
        }
    });
}

function logOut(){
    if(confirm("Logout?")){
        $.ajax({
            type:"post",
            url:"components/addressBook.cfc?method=logoutFunction",
            success:function(result){
                if(result){
                    location.reload();
                }
            }
        })
    }
}

function spreadsheetDownload() {
    if(confirm("Download .xlsx file?")){
        $.ajax({
            type:"post",
            url:"components/addressBook.cfc?method=spreadsheetDownload"
        })
    }
}

function pdfDownloadAlert(){
    if(confirm("Download .pdf file?")){
        return true
    }
    else{
        return false
    }
}

function printFunction(){
    var page=document.body.innerHTML
    var print=document.getElementById("printSection").innerHTML
    document.body.innerHTML=print
    window.print()
    document.body.innerHTML-page
    location.reload()
}

function closeModal(){
    document.getElementById("modalError").innerHTML=""
}