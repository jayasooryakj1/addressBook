<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap-5.0.2-dist/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/homeStyle.css">
        <title>Home</title>
    </head>
    <body>
        
        <div class="header d-flex align-items-center p-2 d-flex">
            <div class="ms-5 me-2">
                <img src="assets/images/phone-book.png" alt="phoneBook" width="40">
                ADDRESS BOOK
            </div>
            <form method="post">
                <div class="login">
                    <button type="button" class="logoutButton" onclick="logOut()" name="logout">
                        <img src="assets/images/logout.png" alt="logout" width="20">
                        Logout
                    </button>
                </div>
            </form>
        </div>
        <div class="homeHeader downloadIcons bg-white d-flex align-items-center">
            <form method="post" class="d-flex headerDonwloadIcons">
                <div class="downloadIcons">
                    <button type="submit" name="pdfDownload" onclick="return pdfDownloadAlert()">
                        <img src="assets/images/pdf.png" alt="pdfImage" width="30">
                    </button>
                </div>
                <div class="ms-2">
                    <button type="button" name="ssDownload" onclick="spreadsheetDownload()">
                        <img src="assets/images/excel.png" alt="excelImage" width="30">
                    </button>
                </div>
                <div class="ms-2">
                    <button type="button" name="print" onclick="printFunction()">
                        <img src="assets/images/printer.png" alt="printerImage" width="30">
                    </button>
                </div>
            </form>
        </div>

        <!--- PDF BODY --->
        <cfif structKeyExists(form, "pdfDownload")>
            <cfset local.pdfObj = createObject("component", "components.addressBook")>
            <cfset local.result = local.pdfObj.pdfDownloader()>
            <cfset local.roleVar = "">
            <cfset local.pdfFileName = "jayasoorya"&dateTimeFormat(now(), "dd-mm-yyyy.HH.nn.ss")>
            <cfdocument  format="pdf" fileName="pdfDownload/#pdfFileName#.pdf" orientation="landscape">
                <table border="1">
                    <tr>
                        <th>photo</th>
                        <th>title</th>
                        <th>fname</th>
                        <th>lname</th>
                        <th>gender</th>
                        <th>dob</th>
                        <th>address</th>
                        <th>street</th>
                        <th>district</th>
                        <th>state</th>
                        <th>country</th>
                        <th>pincode</th>
                        <th>email</th>
                        <th>phoneNumber</th>
                        <th>roles</th>
                    </tr>
                    <cfoutput>
                        <cfloop query="#result#">
                            <tr>
                                <td><img src="#result.photo#" width="30"></td>
                                <td>#local.result.title#</td>
                                <td>#local.result.fname#</td>
                                <td>#local.result.lname#</td>
                                <td>#local.result.gender#</td>
                                <td>#local.result.dob#</td>
                                <td>#local.result.address#</td>
                                <td>#local.result.street#</td>
                                <td>#local.result.district#</td>
                                <td>#local.result.state#</td>
                                <td>#local.result.country#</td>
                                <td>#local.result.pincode#</td>
                                <td>#local.result.email#</td>
                                <td>#local.result.phoneNumber#</td>
                                <td>#local.result.roleNames#</td>
                            </tr>
                        </cfloop>
                    </cfoutput>
                </table>
            </cfdocument>
        </cfif>
        
        <div class="d-flex justify-content-center mt-4">

            <!--- USER CARD --->
            <div class="userCard bg-white d-flex flex-column align-items-center pt-3 pb-4">
                <div>
                    <cfoutput>
                        <img class="userImage" src="#session.userImage#" alt="userDefault" height="70" width="70">
                    </cfoutput>
                </div>
                <div class="userName mt-4" id="userName">
                    <cfoutput>
                        <b>#session.user#</b>
                    </cfoutput>
                </div>
                <button type="button" onclick="createContact()" class="btn btn-primary rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                    CREATE CONTACT
                </button>
                <button type="button" class="btn btn-primary rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#uploadContact">
                    UPLOAD CONTACT
                </button>
            </div>

            <!-- UPLOAD -->
            <div class="modal fade" data-bs-backdrop="static" id="uploadContact" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header px-4 mt-2">
                            <button class="btn btn-primary" onclick="spreadsheetDownload()">Template with data</button>
                            <button class="btn btn-success" onclick="spreadsheetHead()">Plain Template</button>
                        </div>
                        <div class="modal-body">
                            <div class="uploadHeader">
                                <h3>Upload Excel File</h3>
                            </div>
                            <div>
                                <form id="spreadsheetForm" method="post"  enctype="multipart/form-data">
                                    <label class="uploadExcel mt-5" for="spreadsheetUpload"><b>Upload Excel*</b></label><br>
                                    <input class="mt-3" type="file" id="spreadsheetUpload">
                                </form>
                            </div>
                            <div id="contactsUploadError"></div>
                        </div>
                        <div class="modal-footer mt-3 p-3 d-flex">
                            <button class="me-5 border-success greenText bg-white">Download Result</button>
                            <button type="button" class="ms-5 btn btn-primary rounded-pill" onclick="spreadsheetUpload()">SUBMIT</button>
                            <button type="button" class="btn uploadExcel border-primary rounded-pill" data-bs-dismiss="modal"  onclick="reloadForm()">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--- CREATE/EDIT MODAL --->
            <div class="modal fade w-100" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <form id="contactForm" method="post"  enctype="multipart/form-data">
                    <div class="modal-dialog  modal-lg">
                        <div class="modal-content">
                            <div class="modal-body p-0 d-flex">
                                <div class="bgBlue"></div>
                                <div class="modalBody px-5">
                                    <div class="modalHeader text-center my-5">
                                        <h5><b id="modalHeadingChange"></b></h5>
                                    </div>
                                    <div class="modalHeadings partHeading">
                                        <h5>Personal Contact</h5>
                                    </div>
                                    <div class="d-hidden">
                                        <input type="hidden" id="contactIdHidden" name="contactId">
                                    </div>
                                    <div class="d-flex">
                                        <div class="modalHeadings mt-3">
                                            <b>Title *</b><br>                                            
                                            <select class="mt-3" id="title" name="title" id="title">
                                                <option></option>
                                                <option value="Ms">Ms</option>
                                                <option value="Mr">Mr</option>
                                            </select>
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>First Name *</b><br>
                                            <input class="mt-3" type="text" id="fname" name="fname">
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Last Name *</b><br>
                                            <input class="mt-3" type="text" id="lname" name="lname">                                        </div>
                                        </div>
                                    <div class="d-flex mt-2">
                                        <div class="modalHeadings2 mt-3">
                                            <b>Gender *</b><br>
                                            <select class="mt-3" name="gender" id="gender">
                                                <option></option>
                                                <option value="male">male</option>
                                                <option value="female">female</option>
                                            </select>
                                        </div>
                                        <div class="modalHeadings2 mt-3 ms-4">
                                            <b>Date of Birth *</b><br>
                                            <cfoutput>
                                                <input class="mt-3 dob" name="dob" id="dob" type="date" max=#dateFormat(now(),"yyyy-mm-dd")#>
                                            </cfoutput>
                                        </div>
                                    </div>
                                    <div class="modalHeadings2 mt-3 ms-4">
                                        <b>Upload Photo</b><br>
                                        <input class="mt-3 profilePic pt-1" name="photo" id="photo" type="file">
                                        <div class="d-hidden">
                                            <input type="hidden" id="imgHidden" name="imgHidden">
                                        </div>
                                    </div>
                                    <div class="modalHeadings partHeading mt-4">
                                        <h5>Contact Details</h5>
                                    </div>
                                    <div class="d-flex">
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Address *</b><br>
                                            <input class="mt-3" type="text" name="address" id="address">
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Street *</b><br>
                                            <input class="mt-3" type="text" name="street" id="street">
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>District *</b><br>
                                            <input class="mt-3" type="text" name="district" id="district">
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>State *</b><br>
                                            <input class="mt-3" type="text" name="state" id="state">
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Country *</b><br>
                                            <input class="mt-3" type="text" name="country" id="country">
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Pincode *</b><br>
                                            <input class="mt-3" type="text" name="pincode" id="pincode">
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Email id *</b><br>
                                            <input class="mt-3" type="email" name="email" id="email">
                                        </div>
                                        <div class="modalHeadings mt-3 ms-4">
                                            <b>Phone number *</b><br>
                                            <input class="mt-3" type="text" name="phoneNumber" id="phoneNumber">
                                        </div>
                                    </div>
                                    <div class="modalHeadings mt-3 ms-4">
                                        <b>Role *</b><br>
                                        <select id="roles" class="form-control selectpicker" name="role" multiple>
                                            <option value=1>One</option>
                                            <option value=2>Two</option>
                                            <option value=3>Three</option>
                                        </select>
                                    </div>
                                    <div id="modalError" class="text-center mt-4"></div>
                                </div>
                                <div class="userPic text-center">
                                    <cfoutput>
                                        <img id="contactCreationImage" class="userImage" src="assets/imageUploads/userDefault.jpg" alt="userDefault" height="70" width="70">
                                    </cfoutput>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" onclick="closeModal()" data-bs-dismiss="modal">
                                    Close
                                </button>
                                <input type="button" name="create" id="submit" value="submit" onclick="modalValidation()" class="btn btn-primary">
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!--- CREATE --->
            <cfif structKeyExists(form, "create")>
                <cfset uploadLocation = "./assets/imageUploads/">
                <cfif structKeyExists(form, "photo") AND len(form.photo)>
                    <cffile action="upload"
                            filefield="form.photo"
                            destination="#expandPath(uploadLocation)#"
                            nameconflict="makeunique"
                            result="fileName">
                    <cfset contact[photo] = uploadLocation&fileName.serverfile>
                <cfelse>
                    <cfset form.photo = "/userDefault.jpg">
                    <cfset contact[photo] = uploadLocation&"#form.photo#">
                </cfif>
                <cfloop collection="#form#" item="item">
                    <cfset contact[item] = form[item]>
                </cfloop>
                <cfset obj = createObject("component", "components.addressBook")>
                <cfset result = obj.contactsEntry(
                    contactStruct = contact
                )>
            </cfif>

            <!--- DISPLAY CONTACTS --->
            <div class="contacts bg-white ms-3">
                <cfset value = createObject("component", "components.addressBook")>
                <cfset result = value.displayContacts()>
                <div id="printSection">
                    <form method="post">
                        <cfoutput>
                            <table class="w-100">
                                <tr class="tableHeading">
                                    <th class="tableImage text-center"></th>
                                    <th class="tableName">NAME</th>
                                    <th class="tableEmail">EMAIL ID</th>
                                    <th>PHONE NUMBER</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                                <!---<cfloop query="#result#">
                                    <tr class="borderBottom">
                                        <td class="text-center pt-3 pb-3"><img src="#result.photo#" height="70" width="70" class="contactPic"></td>
                                        <td>#result.fname# #result.lname#</td>
                                        <td>#result.email#</td>
                                        <td>#result.phoneNumber#</td>
                                        <td><button type="button" class="printHidden btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##staticBackdrop" value="#result.contactId#" name="edit" id="editButton" onclick="editContact(this)">Edit</button></td>
                                        <td><button class="printHidden btn btn-primary optionsButton" value="#result.contactId#" name="dlt" onclick="deleteContact(this)" type="button">Delete</button></td>
                                        <td><button type="button" class="printHidden btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##viewModal" value="#result.contactId#" name="view" onclick="viewContact(this)">View</button></td>
                                    </tr>
                                </cfloop>--->
                                <cfset ormReload()>
                                <cfset var = entityLoad("contacts", {_createdBy=#session.userid#, active=1})>
                                <cfloop array="#var#" item="item">
                                    <tr class="borderBottom" id="#item.getcontactId()#">
                                        <td class="text-center pt-3 pb-3"><img src="#item.getphoto()#" height="70" width="70" class="contactPic"></td>
                                        <td>#item.getfname()# #item.getlname()#</td>
                                        <td>#item.getemail()#</td>
                                        <td>#item.getphoneNumber()#</td>
                                        <td>
                                            <button type="button" class="printHidden btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##staticBackdrop" value="#item.getcontactId()#" name="edit" id="editButton" onclick="editContact(this)">
                                                Edit
                                            </button>
                                        </td>
                                        <td>
                                            <button class="printHidden btn btn-primary optionsButton" value="#item.getcontactId()#" name="dlt" onclick="deleteContact(this)" type="button">
                                                Delete
                                            </button>
                                        </td>
                                        <td>
                                            <button type="button" class="printHidden btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##viewModal" value="#item.getcontactId()#" name="view" onclick="viewContact(this)">
                                                View
                                            </button>
                                        </td>
                                    </tr>
                                </cfloop>
                            </table>
                        </cfoutput>
                    </form>
                </div>
            </div>
        </div>

        <!--- EDIT --->
            <cfif structKeyExists(form, "edit")>
                <cfset uploadLocation = "./assets/imageUploads/">
                <cfif structKeyExists(form, "photo") AND len(form.photo)>
                    <cffile action="upload"
                            filefield="form.photo"
                            destination="#expandPath(uploadLocation)#"
                            nameconflict="makeunique"
                            result="fileName">
                    <cfset contact[photo] = uploadLocation&fileName.serverfile>
                <cfelse>
                    <cfset contact[photo] = "#form.imgHidden#">
                </cfif>
                <cfloop collection="#form#" item="item">
                    <cfset contact[item] = form[item]>
                </cfloop>
                <cfset obj = createObject("component", "components.addressBook")>
                <cfset result = obj.contactsUpdate(
                    contactUpdate = contact
                )>
            </cfif>
        
        <!--- VIEW MODAL --->
        <div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-body d-flex p-0">
                        <div class="bgBlue"></div>
                        <div class="viewBody">
                            <div class="viewHeader mt-5"><h4><b>CONTACT DETAILS</b></h4></div>
                            <div class="d-flex ms-5 mt-5">
                                <div class="detailsLabel"><b>Name</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsName"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Gender</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsGender"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Date of Birth</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsDob"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Address</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsAddress"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Pincode</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsPincode"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Email Id</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsEmail"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Phone</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsPhone"></div>
                            </div>
                            <div class="d-flex ms-5 mt-3">
                                <div class="detailsLabel"><b>Role</b></div>
                                <div class="detailsLabel2"><b>:</b></div>
                                <div class="ms-5" id="detailsRole"></div>
                            </div>
                            <div class="text-center my-5">
                                <button type="button" class="btn btn-secondary viewClose" data-bs-dismiss="modal">
                                    Close
                                </button>
                            </div>
                        </div>
                        <div class="viewContactPic text-center"><img id="contactProfilePic" alt="profile pic" width="100" height="100"></div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/script.js"></script>
    </body>
</html>