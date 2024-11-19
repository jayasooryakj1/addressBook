<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../bootstrap-5.0.2-dist/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/homeStyle.css">
        <title>Home</title>
    </head>
    <body>
        <cfif structKeyExists(session, "user")>
            <div class="header d-flex align-items-center p-2 d-flex">
                <div class="ms-5 me-2"><img src="assets/images/phone-book.png" alt="phoneBook" width="40">ADDRESS BOOK</div>
                <div class="login"><a href="index.cfm"><img src="assets/images/logout.png" alt="logout" width="20">Logout</a></div>
            </div>
            <div class="homeHeader bg-white d-flex align-items-center justify-content-center">
                <div><img class="pdfImage" src="assets/images/pdf.png" alt="pdfImage" width="30"></div>
                <div><img class="ms-3" src="assets/images/excel.png" alt="excelImage" width="30"></div>
                <div><img class="ms-3" src="assets/images/printer.png" alt="printerImage" width="30"></div>
            </div>
            <div class="d-flex justify-content-center mt-4">
                <div class="userCard bg-white d-flex flex-column align-items-center pt-3 pb-4">
                    <div><img class="userImage" src="assets/images/userDefault.jpg" alt="userDefault" width="70"></div>
                    <div class="userName mt-4" id="userName"><cfoutput><b>#session.user#</b></cfoutput></div>
                    <button type="button" onclick="createContact()" class="btn btn-primary rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        CREATE CONTACT
                    </button>
                </div>
                <div class="modal fade w-100" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <form method="post"  enctype="multipart/form-data">
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
                                                <input class="mt-3 dob" name="dob" id="dob" type="date">
                                            </div>
                                        </div>
                                        <div class="modalHeadings2 mt-3 ms-4">
                                            <b>Upload Photo</b><br>
                                            <input class="mt-3 profilePic pt-1" name="photo" id="photo" type="file">
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
                                        <div id="modalError" class="text-center mt-4"></div>
                                    </div>
                                    <div class="userPic text-center">
                                        <img src="assets/images/excel.png" alt="userPic" width="100">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <input type="submit" name="submit" id="submit" value="submit" onclick="modalValidation()" class="btn btn-primary">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <cfif structKeyExists(form, "submit")>
                    <cfset local.uploadLocation = "./assets/imageUploads/">
                    <cffile action="upload"
                            filefield="form.photo"
                            destination="#expandPath(local.uploadLocation)#"
                            nameconflict="makeunique"
                            result="fileName">
                    <cfset local.contact[photo] = local.uploadLocation&fileName.serverfile>
                    <cfloop collection="#form#" item="item">
                        <cfset local.contact[item] = form[item]>
                    </cfloop>
                    <cfset local.obj = createObject("component", "components.addressBook")>
                    <cfset local.result = local.obj.contactsEntry(local.contact)>
                </cfif>
                <div class="contacts bg-white ms-3">
                    <cfset local.value = createObject("component", "components.addressBook")>
                    <cfset local.result = local.value.displayContacts()>
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
                                <cfloop query="#local.result#">
                                    <tr class="borderBottom">
                                        <td class="text-center pt-3 pb-3"><img src="#local.result.photo#" height="70" width="70" class="contactPic"></td>
                                        <td>#local.result.fname# #local.result.lname#</td>
                                        <td>#local.result.email#</td>
                                        <td>#local.result.phoneNumber#</td>
                                        <td><button class="optionsButton">Edit</button></td>
                                        <td><button class="optionsButton">Delete</button></td>
                                        <td><button class="optionsButton">View</button></td>
                                    </tr>
                                </cfloop>
                            </table>
                        </cfoutput>
                    </form>
                </div>
            </div>
        </cfif>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js"></script>
        <script src="js/script.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>