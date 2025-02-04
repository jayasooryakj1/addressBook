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
                <form method="post">
                    <div class="login"><button type="button" class="logoutButton" onclick="logOut()" name="logout"><img src="assets/images/logout.png" alt="logout" width="20">Logout</button></div>
                </form>
            </div>
            <div class="homeHeader downloadIcons bg-white d-flex align-items-center">
                <form method="post" class="d-flex headerDonwloadIcons">
                    <div class="downloadIcons"><button type="submit" name="pdfDownload"><img src="assets/images/pdf.png" alt="pdfImage" width="30"></button></div>
                    <div class="ms-2"><button type="submit" name="spreadsheetDownload"><img src="assets/images/excel.png" alt="excelImage" width="30"></button></div>
                    <div class="ms-2"><button type="submit" name="print"><img src="assets/images/printer.png" alt="printerImage" width="30"></button></div>
                </form>
            </div>
            <cfif structKeyExists(form, "spreadsheetDownload")>
                <cfset local.spreadObj = createObject("component", "components.addressBook")>
                <cfset local.spreadResult = local.spreadObj.spreadsheetDownload()>
            </cfif>
            <div class="d-flex justify-content-center mt-4">
                <div class="userCard bg-white d-flex flex-column align-items-center pt-3 pb-4">
                    <div><cfoutput><img class="userImage" src="#session.userImage#" alt="userDefault" height="70" width="70"></cfoutput></div>
                    <div class="userName mt-4" id="userName"><cfoutput><b>#session.user#</b></cfoutput></div>
                    <button type="button" onclick="createContact()" class="btn btn-primary rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        CREATE CONTACT
                    </button>
                </div>

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
                                                <input class="mt-3 dob" name="dob" id="dob" type="date">
                                            </div>
                                        </div>
                                        <div class="modalHeadings2 mt-3 ms-4">
                                            <b>Upload Photo</b><br>
                                            <input class="mt-3 profilePic pt-1" name="photo" id="photo" type="file">
                                            <div class="d-hidden"><input type="hidden" id="imgHidden" name="imgHidden"></div>
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
                                        <cfoutput><img id="contactCreationImage" class="userImage" src="assets/imageUploads/userDefault.jpg" alt="userDefault" height="70" width="70"></cfoutput>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <input type="submit" name="" id="submit" value="submit" onclick="modalValidation()" class="btn btn-primary">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <cfif structKeyExists(form, "create")>
                    <cfset local.uploadLocation = "./assets/imageUploads/">
                    <cfif structKeyExists(form, "photo") AND len(form.photo)>
                        <cffile action="upload"
                                filefield="form.photo"
                                destination="#expandPath(local.uploadLocation)#"
                                nameconflict="makeunique"
                                result="fileName">
                        <cfset local.contact[photo] = local.uploadLocation&fileName.serverfile>
                    <cfelse>
                        <cfset form.photo = "/userDefault.jpg">
                        <cfset local.contact[photo] = local.uploadLocation&"#resultStruct.photo#">
                    </cfif>
                    <cfloop collection="#form#" item="item">
                        <cfset local.contact[item] = form[item]>
                    </cfloop>
                    <cfset local.obj = createObject("component", "components.addressBook")>
                    <cfset local.result = local.obj.contactsEntry(local.contact)>
                </cfif>

                <cfif structKeyExists(form, "edit")>
                    <cfset local.uploadLocation = "./assets/imageUploads/">
                    <cfif structKeyExists(form, "photo") AND len(form.photo)>
                        <cffile action="upload"
                                filefield="form.photo"
                                destination="#expandPath(local.uploadLocation)#"
                                nameconflict="makeunique"
                                result="fileName">
                        <cfset local.contact[photo] = local.uploadLocation&fileName.serverfile>
                    <cfelse>
                        <cfset local.contact[photo] = "#form.imgHidden#">
                    </cfif>
                    <cfloop collection="#form#" item="item">
                        <cfset local.contact[item] = form[item]>
                    </cfloop>
                    <cfset local.obj = createObject("component", "components.addressBook")>
                    <cfset local.result = local.obj.contactsUpdate(local.contact)>
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
                                        <td><button type="button" class="btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##staticBackdrop" value="#local.result.contactId#" name="edit" onclick="editContact(this)">Edit</button></td>
                                        <td><button class="btn btn-primary optionsButton" value="#local.result.contactId#" name="dlt" onclick="deleteContact(this)" type="button">Delete</button></td>
                                        <td><button type="button" class="btn btn-primary optionsButton" data-bs-toggle="modal" data-bs-target="##viewModal" value="#local.result.contactId#" name="view" onclick="viewContact(this)">View</button></td>
                                    </tr>
                                </cfloop>
                            </table>
                        </cfoutput>
                    </form>
                </div>
            </div>
        </cfif>

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
                            <div class="text-center my-5">
                                <button type="button" class="btn btn-secondary viewClose" data-bs-dismiss="modal">Close</button>
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