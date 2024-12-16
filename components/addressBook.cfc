<cfcomponent>

    <cffunction  name="signup" returntype="string">
        <cfargument  name="email">
        <cfargument  name="userName">
        <cfargument  name="inputImage">
        <cfargument  name="password">
        <cfargument  name="fullName">
        <cfset local.uploadLocation = "./assets/imageUploads/">
        <cfset local.imageLink = "#local.uploadLocation##arguments.inputImage#">
        <cfset local.hashedPassword = hash("#arguments.password#", "SHA-256", "UTF-8")>
        <cfquery name="local.query">
            SELECT 
                COUNT(userName) AS count,
                COUNT(email) AS countEmail 
            FROM users 
            WHERE userName=<cfqueryparam value='#arguments.userName#' cfsqltype="CF_SQL_VARCHAR"> 
                OR email=<cfqueryparam value='#arguments.email#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif local.query.count GT 0 or local.query.countEmail GT 0>
            <cfset local.result = "Username or email already exists">
        <cfelse>
            <cfquery name="local.insertValues">
                INSERT INTO users (
                    fullName, 
                    email, 
                    userName, 
                    userImage, 
                    pwd
                    ) 
                    VALUES(
                    <cfqueryparam value='#arguments.fullName#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.email#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.userName#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#local.imageLink#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#local.hashedPassword#' cfsqltype="CF_SQL_VARCHAR">
                )
            </cfquery>
            <cfset local.result = "User added">
        </cfif>
        <cfreturn local.result>
    </cffunction>

    <cffunction  name="login" returntype="string">
        <cfargument  name="userName">
        <cfargument  name="password">
        <cfset local.hashedPassword = hash("#arguments.password#", "SHA-256", "UTF-8")>
        <cfquery name="local.check">
            SELECT
                email, 
                pwd, 
                userImage, 
                userId 
            FROM 
                users 
            WHERE 
                userName=<cfqueryparam value='#arguments.userName#'>
                AND pwd = <cfqueryparam value='#local.hashedPassword#'>
        </cfquery>
        <cfif queryRecordCount(local.check)>
            <cfset local.result = "true">
            <cfset session.user = arguments.userName>
            <cfset session.userid = local.check.userId>
            <cfset session.userImage = local.check.userImage>
            <cfset session.email = local.check.email>
        <cfelse>
            <cfset local.result = "Incorrect username or password">
        </cfif>
        <cfreturn local.result>
    </cffunction>

    <cffunction  name="contactsEntry">
        <cfargument  name="contactStruct">
        <cfset local.imageLink = "#arguments.contactStruct[photo]#">
        <cfset local.today = now()>
        <cfquery name="local.entry" result="local.entryResult">
            INSERT INTO contacts (
                title, 
                fname, 
                lname, 
                gender, 
                dob, 
                photo, 
                address, 
                street, 
                district, 
                state, 
                country, 
                pincode, 
                email, 
                phoneNumber, 
                _createdBy,
                _createdOn
                ) 
                 VALUES(
                <cfqueryparam value='#arguments.contactStruct["title"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["fname"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["lname"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["gender"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["dob"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#local.imageLink#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["address"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["street"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["district"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["state"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["country"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["pincode"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["email"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#arguments.contactStruct["phoneNumber"]#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#local.today#' cfsqltype="CF_SQL_DATE">
            )
        </cfquery>
        <cfloop list="#arguments.contactStruct["role"]#" item="item" delimiters=",">
            <cfquery name="local.insertRole">
                INSERT INTO 
                    contactRoles(
                        contactid,
                        roleId
                )
                VALUES(
                    <cfqueryparam value='#local.entryResult.generatedkey#'cfsqltype="CF_SQL_INTEGER">,
                    <cfqueryparam value='#item#'cfsqltype="CF_SQL_INTEGER">
                )
            </cfquery>
        </cfloop>
    </cffunction>

    <cffunction  name="displayContacts" returnType="query">
        <cfquery name="local.contacts">
            SELECT 
                photo, 
                fname, 
                lname,
                email, 
                phoneNumber, 
                contactId 
            FROM contacts 
            WHERE _createdBy=<cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_INTEGER">
            AND active=<cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
        </cfquery>
        <cfreturn "#contacts#">
    </cffunction>

    <cffunction  name="deleteFunction" access="remote" returntype="any">
        <cfargument  name="dlt">
        <!---<cfquery name="local.dltContact">
            DELETE 
            FROM contactRoles 
            WHERE contactId =<cfqueryparam value='#arguments.dlt#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfquery name="local.dltQuery">
            DELETE 
            FROM contacts 
            WHERE contactId =<cfqueryparam value='#arguments.dlt#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>--->
        <cfquery name="local.dltContact">
            UPDATE contacts
            SET
                active = <cfqueryparam value=0 cfsqltype="CF_SQL_INTEGER">
            WHERE
                contactId =<cfqueryparam value='#arguments.dlt#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn true>
    </cffunction>

    <cffunction  name="checkPic" returntype="query">
        <cfargument  name="userid">
        <cfquery name="local.pic">
            SELECT 
                photo 
            FROM contacts 
            WHERE userId=<cfqueryparam value='#arguments.userid#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn local.pic.photo>
    </cffunction>

    <cffunction  name="contactsUpdate">
        <cfargument  name="contactUpdate">
        <cfset local.imageLink = "#arguments.contactUpdate[photo]#">
        <cfset local.today = now()>
        <cfquery name="local.update">
            UPDATE contacts 
            SET 
                title = <cfqueryparam value='#contactUpdate["title"]#' cfsqltype="CF_SQL_VARCHAR">,
                fname = <cfqueryparam value='#contactUpdate["fname"]#' cfsqltype="CF_SQL_VARCHAR">,
                lname = <cfqueryparam value='#contactUpdate["lname"]#' cfsqltype="CF_SQL_VARCHAR">,
                gender = <cfqueryparam value='#contactUpdate["gender"]#' cfsqltype="CF_SQL_VARCHAR">,
                dob = <cfqueryparam value='#contactUpdate["dob"]#' cfsqltype="CF_SQL_VARCHAR">,
                photo = <cfqueryparam value='#local.imageLink#' cfsqltype="CF_SQL_VARCHAR">,
                address = <cfqueryparam value='#contactUpdate["address"]#' cfsqltype="CF_SQL_VARCHAR">,
                street = <cfqueryparam value='#contactUpdate["street"]#' cfsqltype="CF_SQL_VARCHAR">,
                district = <cfqueryparam value='#contactUpdate["district"]#' cfsqltype="CF_SQL_VARCHAR">,
                state = <cfqueryparam value='#contactUpdate["state"]#' cfsqltype="CF_SQL_VARCHAR">,
                country = <cfqueryparam value='#contactUpdate["country"]#' cfsqltype="CF_SQL_VARCHAR">,
                pincode = <cfqueryparam value='#contactUpdate["pincode"]#' cfsqltype="CF_SQL_VARCHAR">,
                email = <cfqueryparam value='#contactUpdate["email"]#' cfsqltype="CF_SQL_VARCHAR">,
                phoneNumber = <cfqueryparam value='#contactUpdate["phoneNumber"]#' cfsqltype="CF_SQL_VARCHAR">,
                _updatedOn = <cfqueryparam value='#local.today#' cfsqltype="CF_SQL_DATE">,
                _editedBy = <cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">
                WHERE contactId = <cfqueryparam value='#contactUpdate["contactId"]#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfquery name="local.dltRoles">
            DELETE 
            FROM contactRoles
            WHERE contactId = <cfqueryparam value='#contactUpdate["contactId"]#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfloop list="#arguments.contactUpdate["role"]#" item="item" delimiters=",">
            <cfquery name="local.insertRole">
                INSERT INTO contactRoles(
                    contactid,
                    roleId
                )
                VALUES(
                    <cfqueryparam value='#contactUpdate["contactId"]#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#item#'cfsqltype="CF_SQL_INTEGER">
                )
            </cfquery>
        </cfloop>
        <cflocation  url="home.cfm">
    </cffunction>

    <cffunction  name="logoutFunction" access="remote">
        <cfset structClear(session)>
        <cfreturn true>
    </cffunction>

    <cffunction name="emailExist" access="remote">
        <cfargument name="existentEmail">
        <cfargument name="existentNumber">
        <cfargument name="contactId" default="">
        <cfquery name="local.qry">
            SELECT 
                email, 
                contactId 
            FROM contacts 
            WHERE email=<cfqueryparam value='#arguments.existentEmail#' cfsqltype="CF_SQL_VARCHAR">
            AND _createdBy=<cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">
            AND active=<cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
        </cfquery>
        <cfloop query="qry">
            <cfif qry.contactId NEQ arguments.contactId>
                <cfreturn true>
            </cfif>
        </cfloop>
        <cfquery name="local.number">
            SELECT 
                phoneNumber, 
                contactId 
            FROM contacts 
            WHERE phoneNumber=<cfqueryparam value='#arguments.existentNumber#' cfsqltype="CF_SQL_VARCHAR">
            AND _createdBy=<cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">
            AND active=<cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
        </cfquery>
        <cfloop query="local.number">
            <cfif number.contactId NEQ arguments.contactId>
                <cfreturn true>
            </cfif>
        </cfloop>
        <cfif session.email EQ arguments.existentEmail>
            <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction  name="getData">
        <cfargument  name="id">
        <cfif structKeyExists(arguments, "id")>
            <cfset local.colName = "contacts.contactId">
            <cfset local.condition = arguments.id>
        <cfelse>
            <cfset local.colName = "contacts._createdBy">
            <cfset local.condition = session.userId>
        </cfif>
        <cfquery name="local.gotData">
            SELECT 
                title,
                contacts.contactid,
                fname, 
                lname, 
                gender, 
                dob, 
                photo, 
                address, 
                street, 
                district, 
                state, 
                country, 
                pincode, 
                email, 
                phoneNumber,
				STRING_AGG(roleName,', ') AS roleNames,
				STRING_AGG(ro.roleId, ', ')AS roleId
            FROM 
                contacts
            LEFT JOIN contactRoles AS cr ON cr.contactId = contacts.contactId
            LEFT JOIN roles AS ro ON ro.roleId = cr.roleId
            WHERE #local.colName#=<cfqueryparam value="#local.condition#" cfsqltype="CF_SQL_INTEGER">
            GROUP BY 
                title, 
                contacts.contactid,
                fname, 
                lname, 
                gender, 
                dob, 
                photo, 
                address, 
                street, 
                district, 
                state, 
                country, 
                pincode, 
                email, 
                phoneNumber,
                active
        </cfquery>
        <cfif structKeyExists(arguments, "id")>
            <!---<cfset local.joinObj = getRoles(arguments.id)>--->
            <cfset local.contactDetails["title"] = local.gotData.title>
            <cfset local.contactDetails["contactid"] = local.gotData.contactid>
            <cfset local.contactDetails["fname"] = local.gotData.fname>
            <cfset local.contactDetails["lname"] = local.gotData.lname>
            <cfset local.contactDetails["gender"] = local.gotData.gender>
            <cfset local.contactDetails["dob"] = local.gotData.dob>
            <cfset local.contactDetails["photo"] = local.gotData.photo>
            <cfset local.contactDetails["address"] = local.gotData.address>
            <cfset local.contactDetails["street"] = local.gotData.street>
            <cfset local.contactDetails["district"] = local.gotData.district>
            <cfset local.contactDetails["state"] = local.gotData.state>
            <cfset local.contactDetails["country"] = local.gotData.country>
            <cfset local.contactDetails["pincode"] = local.gotData.pincode>
            <cfset local.contactDetails["email"] = local.gotData.email>
            <cfset local.contactDetails["phoneNumber"] = local.gotData.phoneNumber>
            <cfset local.contactDetails["roles"] = local.gotData.roleNames>
            <cfset local.contactDetails["roleId"] = local.gotData.roleId>
            <cfreturn contactDetails>
        <cfelse>
            <cfreturn local.gotData>
        </cfif>
    </cffunction>

    <!---<cffunction  name="getRoles">
        <cfargument  name="contactId">
        <cfquery name="join">
            SELECT 
                roleName,
                contactRoles.roleId
            FROM contactRoles
            INNER JOIN roles
            ON contactRoles.roleId = roles.roleId
            WHERE contactId=<cfqueryparam value='#arguments.contactId#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn join>
    </cffunction>--->

    <cffunction  name="spreadsheetDownload" access="remote">
        <cfset local.spreadSheetData = getData()>
        <cfset local.roleArray = arrayNew(1)>
        <!---<cfloop query="local.spreadSheetData">
            <cfset local.roleString = "">
            <cfset local.spreadSheetRole = getRoles(local.spreadSheetData.contactId)>
            <cfloop query="local.spreadSheetRole">
                <cfset local.roleString = local.roleString&" "&local.spreadSheetRole.roleName>
            </cfloop>
            <cfset local.roleString = trim(local.roleString)>
            <cfset local.roleString = Replace(local.roleString, " ", ",", "all")>
            <cfset arrayAppend(local.roleArray, local.roleString)>
        </cfloop>
        <cfset queryAddColumn(local.spreadSheetData, "role", local.roleArray)>--->
        <cfset queryDeleteColumn(local.spreadSheetData, "roleId")>
        <cfset queryDeleteColumn(local.spreadSheetData, "contactId")>
        <cfset local.spreadsheetName = "jayasoorya"&dateTimeFormat(now(), "dd-mm-yyyy.HH.nn.ss")&".xlsx">
        <cfset local.filePath = ExpandPath("../spreadsheetDownloads/"&local.spreadsheetName)>
        <cfspreadsheet action="write" query="local.spreadSheetData" filename="#local.filePath#" overwrite="yes">
        <cfreturn true>
    </cffunction>

    <cffunction  name="spreadSheetHeaders" access="remote">
        <cfset local.plainData = spreadsheetNew("name")>
        <cfset spreadsheetAddRow(local.plainData, 'Title, firstName, lastName, gender, dob, address, street, district, state, country, pincode, email, phoneNumber, roleNames')>
        <cfset local.spreadsheetName = "plainTemplate"&dateTimeFormat(now(), "dd-mm-yyyy.HH.nn.ss")&".xlsx">
        <cfset local.filePath = ExpandPath("../spreadsheetDownloads/"&local.spreadsheetName)>
        <cfspreadsheet action="write" name="local.plainData" filename="#local.filePath#" overwrite="yes">
    </cffunction>

    <cffunction  name="pdfDownloader">
        <cfset local.pdfData = getData()>
        <cfreturn local.pdfData>
    </cffunction>

    <cffunction  name="viewContact" access="remote" returnFormat="JSON">
        <cfargument  name="viewId">
        <cfset local.viewContact = getData(id = arguments.viewId)>
        <cfset local.contactStruct = structNew()>
        <cfset local.contactStruct["name"] = local.viewContact.title&" "&local.viewContact.fname&" "&local.viewContact.lname>
        <cfset local.contactStruct["gender"] = local.viewContact.gender>
        <cfset local.contactStruct["dob"] = dateFormat(local.viewContact.dob, 'dd/mm/yyyy')>
        <cfset local.contactStruct["photo"] = local.viewContact.photo>
        <cfset local.contactStruct["address"] = local.viewContact.address&", "&local.viewContact.street&", "&local.viewContact.district&", "&local.viewContact.state&", "&local.viewContact.country&".">
        <cfset local.contactStruct["pincode"] = local.viewContact.pincode>
        <cfset local.contactStruct["email"] = local.viewContact.email>
        <cfset local.contactStruct["phn"] = local.viewContact.phoneNumber>
        <cfset local.contactStruct["roles"] = local.viewContact.roles>
        <cfreturn local.contactStruct>
    </cffunction>

    <cffunction  name="editContact" returntype="struct" access="remote" returnFormat="JSON">
        <cfargument  name="editId">
        <cfset local.editContact = getData(id = arguments.editId)>
        <!---<cfset local.editRole = getRoles(contactId = local.editContact.contactId)>--->
        <cfset local.contactEdit = structNew()>
        <cfset local.contactEdit["contactId"] = local.editContact.contactId>
        <cfset local.contactEdit["title"] = local.editContact.title>
        <cfset local.contactEdit["fname"] = local.editContact.fname>
        <cfset local.contactEdit["lname"] = local.editContact.lname>
        <cfset local.contactEdit["gender"] = local.editContact.gender>
        <cfset local.contactEdit["dob"] = dateFormat(local.editContact.dob,"yyyy-mm-dd")>
        <cfset local.contactEdit["photo"] = local.editContact.photo>
        <cfset local.contactEdit["address"] = local.editContact.address>
        <cfset local.contactEdit["street"] = local.editContact.street>
        <cfset local.contactEdit["district"] = local.editContact.district>
        <cfset local.contactEdit["state"] = local.editContact.state>
        <cfset local.contactEdit["country"] = local.editContact.country>
        <cfset local.contactEdit["pincode"] = local.editContact.pincode>
        <cfset local.contactEdit["email"] = local.editContact.email>
        <cfset local.contactEdit["phoneNumber"] = local.editContact.phoneNumber>
        <cfset local.contactEdit["roles"] = local.editContact.roleId>
        <cfreturn local.contactEdit>
    </cffunction>

    <cffunction  name="googleLogin">
        <cfargument  name="googleStruct">
        <cfquery name="local.googleProfile">
            SELECT 
                COUNT(email) AS emailCount 
            FROM users 
            WHERE email='#arguments.googleStruct.other.email#'
        </cfquery>
        <cfif local.googleProfile.emailCount GT 0>
            <cfquery name="local.googleCred">
                SELECT 
                    userName, 
                    userid 
                FROM users 
                WHERE email='#arguments.googleStruct.other.email#'
            </cfquery>
            <cfset session.userId = googleCred.userId>
            <cfset session.user = googleCred.userName>
            <cfset session.userImage = arguments.googleStruct.other.picture>
            <cfset session.email = arguments.googleStruct.other.email>
            <cflocation  url="home.cfm">
        <cfelse>
            <cfquery name="local.addGoogle">
                INSERT INTO users (
                    email, 
                    userName, 
                    userImage
                    ) 
                    VALUES(
                    <cfqueryparam value='#arguments.googleStruct.other.email#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.googleStruct.other.given_name#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.googleStruct.other.picture#' cfsqltype="CF_SQL_VARCHAR">
                )
            </cfquery>
            <cfquery name="local.sessionId">
                SELECT userId 
                FROM users 
                WHERE email = <cfqueryparam value='#arguments.googleStruct.other.email#' cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            <cfset session.userId = local.sessionId.userId>
            <cfset session.user = arguments.googleStruct.other.given_name>
            <cfset session.userImage = arguments.googleStruct.other.picture>
            <cfset session.email = arguments.googleStruct.other.email>
            <cflocation  url="home.cfm">
        </cfif>
    </cffunction>

    <cffunction  name="birthday" access="remote">
        <cfset local.today = dateFormat(now(), "mm/dd")>
        <cfset local.birthdayToday= "">
        <cfquery name="local.findBirthday">
            SELECT 
                fname, 
                email, 
                dob 
            FROM contacts
        </cfquery>
        <cfif local.findBirthday.recordcount GT 0>
            <cfloop query="local.findBirthday">
                <cfif dateFormat(local.findbirthday.dob, "mm/dd") EQ "#local.today#">
                    <cfmail  from="jayasooryakj420@gmail.com"  subject="Happy Birthday #local.findBirthday.fname# !!"  to="#findBirthday.email#">
                        Happy Birthday
                    </cfmail>
                </cfif>
            </cfloop>
        </cfif>
    </cffunction>

    <cffunction  name="birthdayCall">
        <cfschedule 
            action="update" 
            task="birthday" 
            operation="HTTPRequest"
            url="http://addressbook.org/birthday.cfm"  
            startDate="#dateFormat(now(), 'yyyy-MM-dd')#"
            file="log.txt" 
            startTime="00:00"  
            interval="daily" 
            repeat="0"
        >
        </cfschedule>
    </cffunction>

    <cffunction  name="spreadsheetUpload" access="remote">
        <cfargument  name="uploadData">
        <cfspreadsheet  action="read" headerrow="1" excludeheaderrow="true" query="uploadedData" src="#arguments.uploadData#">
        
    </cffunction>
    
</cfcomponent>