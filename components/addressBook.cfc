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
        <cfquery name="query">
            select 
                count(userName) as count 
            from users 
            where userName=<cfqueryparam value='#arguments.userName#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfquery name="queryEmail">
            select count(email) as countEmail 
            from users 
            where email=<cfqueryparam value='#arguments.email#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif query.count GT 0 or queryEmail.countEmail GT 0>
            <cfset local.result = "Username or email already exists">
        <cfelse>
            <cfquery name="insertValues">
                insert into users (
                    fullName, 
                    email, 
                    userName, 
                    userImage, 
                    pwd
                    ) 
                    values(
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
        <cfquery name="check">
            select 
                count(username) as count 
            from users 
            where userName=<cfqueryparam value= '#arguments.userName#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif check.count==0>
            <cfset local.result = "Invalid username">
        <cfelse>
            <cfquery name="pass">
                select 
                    email, 
                    pwd, 
                    userImage, 
                    userId 
                from users 
                where userName=<cfqueryparam value='#arguments.userName#'>
            </cfquery>
            <cfif pass.pwd != local.hashedPassword>
                <cfset local.result = "Incorrect password">
            <cfelse>
                <cfset local.result = "true">
                <cfset session.user = arguments.userName>
                <cfset session.userid = pass.userId>
                <cfset session.userImage = pass.userImage>
                <cfset session.email = pass.email>
            </cfif>
        </cfif>
        <cfreturn local.result>
    </cffunction>

    <cffunction  name="contactsEntry">
        <cfargument  name="contactStruct">
        <cfset local.imageLink = "#arguments.contactStruct[photo]#">
        <cfset local.today = now()>
        <cfquery name="entry">
            insert into contacts (
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
                _editedBy,
                 _createdOn, 
                 _updatedOn
                 ) 
                 values(
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
                <cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value='#local.today#' cfsqltype="CF_SQL_DATE">,
                <cfqueryparam value='#local.today#' cfsqltype="CF_SQL_DATE">
            )
        </cfquery>
    </cffunction>

    <cffunction  name="displayContacts" returnType="query">
        <cfquery name="contacts">
            select 
                photo, 
                fname, 
                lname,
                email, 
                phoneNumber, 
                contactId 
            from contacts 
            where _createdBy=<cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn "#contacts#">
    </cffunction>

    <cffunction  name="deleteFunction" access="remote" returntype="any">
        <cfargument  name="dlt">
        <cfquery name="dltQuery">
            delete 
            from contacts 
            where contactId =<cfqueryparam value='#arguments.dlt#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn true>
    </cffunction>

    <cffunction  name="checkPic" returntype="query">
        <cfargument  name="userid">
        <cfquery name="pic">
            select 
                photo 
            from contacts 
            where userId=<cfqueryparam value='#arguments.userid#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn pic.photo>
    </cffunction>

    <cffunction  name="viewContact" returntype="struct" access="remote" returnFormat="JSON">
        <cfargument  name="viewId">
        <cfquery name="viewContact">
            select 
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
                phoneNumber 
            from contacts 
            where contactId=<cfqueryparam value='#arguments.viewId#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfset local.contactStruct = structNew()>
        <cfset local.contactStruct["name"] = viewContact.title&" "&viewContact.fname&" "&viewContact.lname>
        <cfset local.contactStruct["gender"] = viewContact.gender>
        <cfset local.contactStruct["dob"] = dateFormat(viewContact.dob, 'dd/mm/yyyy')>
        <cfset local.contactStruct["photo"] = viewContact.photo>
        <cfset local.contactStruct["address"] = viewContact.address&", "&viewContact.street&", "&viewContact.district&", "&viewContact.state&", "&viewContact.country&".">
        <cfset local.contactStruct["pincode"] = viewContact.pincode>
        <cfset local.contactStruct["email"] = viewContact.email>
        <cfset local.contactStruct["phn"] = viewContact.phoneNumber>
        <cfreturn local.contactStruct>
    </cffunction>

    <cffunction  name="editContact" returntype="struct" access="remote" returnFormat="JSON">
        <cfargument  name="editId">
        <cfquery name="editContact">
            select 
                contactId, 
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
                phoneNumber 
            from contacts 
            where contactId=<cfqueryparam value='#arguments.editId#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfset local.contactEdit = structNew()>
        <cfset local.contactEdit["contactId"] = editContact.contactId>
        <cfset local.contactEdit["title"] = editContact.title>
        <cfset local.contactEdit["fname"] = editContact.fname>
        <cfset local.contactEdit["lname"] = editContact.lname>
        <cfset local.contactEdit["gender"] = editContact.gender>
        <cfset local.contactEdit["dob"] = dateFormat(editContact.dob,"yyyy-mm-dd")>
        <cfset local.contactEdit["photo"] = editContact.photo>
        <cfset local.contactEdit["address"] = editContact.address>
        <cfset local.contactEdit["street"] = editContact.street>
        <cfset local.contactEdit["district"] = editContact.district>
        <cfset local.contactEdit["state"] = editContact.state>
        <cfset local.contactEdit["country"] = editContact.country>
        <cfset local.contactEdit["pincode"] = editContact.pincode>
        <cfset local.contactEdit["email"] = editContact.email>
        <cfset local.contactEdit["phoneNumber"] = editContact.phoneNumber>
        <cfreturn local.contactEdit>
    </cffunction>

    <cffunction  name="contactsUpdate">
        <cfargument  name="contactUpdate">
        <cfset local.imageLink = "#arguments.contactUpdate[photo]#">
        <cfset local.today = now()>
        <cfquery name="update">
            update contacts 
            set 
                title=<cfqueryparam value='#contactUpdate["title"]#' cfsqltype="CF_SQL_VARCHAR">,
                fname=<cfqueryparam value='#contactUpdate["fname"]#' cfsqltype="CF_SQL_VARCHAR">,
                lname=<cfqueryparam value='#contactUpdate["lname"]#' cfsqltype="CF_SQL_VARCHAR">,
                gender=<cfqueryparam value='#contactUpdate["gender"]#' cfsqltype="CF_SQL_VARCHAR">,
                dob=<cfqueryparam value='#contactUpdate["dob"]#' cfsqltype="CF_SQL_VARCHAR">,
                photo=<cfqueryparam value='#local.imageLink#' cfsqltype="CF_SQL_VARCHAR">,
                address=<cfqueryparam value='#contactUpdate["address"]#' cfsqltype="CF_SQL_VARCHAR">,
                street=<cfqueryparam value='#contactUpdate["street"]#' cfsqltype="CF_SQL_VARCHAR">,
                district=<cfqueryparam value='#contactUpdate["district"]#' cfsqltype="CF_SQL_VARCHAR">,
                state=<cfqueryparam value='#contactUpdate["state"]#' cfsqltype="CF_SQL_VARCHAR">,
                country=<cfqueryparam value='#contactUpdate["country"]#' cfsqltype="CF_SQL_VARCHAR">,
                pincode=<cfqueryparam value='#contactUpdate["pincode"]#' cfsqltype="CF_SQL_VARCHAR">,
                email=<cfqueryparam value='#contactUpdate["email"]#' cfsqltype="CF_SQL_VARCHAR">,
                phoneNumber=<cfqueryparam value='#contactUpdate["phoneNumber"]#' cfsqltype="CF_SQL_VARCHAR">,
                _updatedOn=<cfqueryparam value='#local.today#' cfsqltype="CF_SQL_DATE">
            where contactId='#contactUpdate["contactId"]#'
        </cfquery>
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
        <cfquery name="qry">
            select 
                email, 
                contactId 
            from contacts 
            where email=<cfqueryparam value='#arguments.existentEmail#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfloop query="qry">
            <cfif qry.contactId NEQ arguments.contactId>
                <cfreturn true>
            </cfif>
        </cfloop>
        <cfquery name="number">
            select 
                phoneNumber, 
                contactId 
            from contacts 
            where phoneNumber=<cfqueryparam value='#arguments.existentNumber#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfloop query="number">
            <cfif number.contactId NEQ arguments.contactId>
                <cfreturn true>
            </cfif>
        </cfloop>
        <cfif session.email EQ arguments.existentEmail>
            <cfreturn true>
        </cfif>
    </cffunction>

    <cffunction  name="getData" returntype="query">
        <cfquery name="gotData">
            select 
                photo, 
                title, 
                fname, 
                lname, 
                gender, 
                dob, 
                address, 
                street, 
                district, 
                state, 
                country, 
                pincode, 
                email, 
                phoneNumber 
            from contacts 
            where _createdBy=<cfqueryparam value='#session.userid#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfreturn gotData>
    </cffunction>

    <cffunction  name="spreadsheetDownload" access="remote">
        <cfset local.spreadSheetData = getData()>
        <cfset local.spreadsheetName = CreateUUID()&".xlsx">
        <cfset local.filePath = ExpandPath("../spreadsheetDownloads/"&local.spreadsheetName)>
        <cfspreadsheet action="write" query="local.spreadSheetData" filename="#local.filePath#" overwrite="yes">
        <cfreturn true>
    </cffunction>

    <cffunction  name="pdfDownloader">
        <cfset local.pdfData = getData()>
        <cfreturn local.pdfData>
    </cffunction>


    <cffunction  name="googleLogin">
        <cfargument  name="googleStruct">
        <cfquery name="googleProfile">
            select count(email) as emailCount from users where email='#arguments.googleStruct.other.email#'
        </cfquery>
        <cfif googleProfile.emailCount GT 0>
            <cfquery name="googleCred">
                select 
                    userName, 
                    userid 
                from users 
                where email='#arguments.googleStruct.other.email#'
            </cfquery>
            <cfset session.userId = googleCred.userId>
            <cfset session.user = googleCred.userName>
            <cfset session.userImage = arguments.googleStruct.other.picture>
            <cfset session.email = arguments.googleStruct.other.email>
            <cflocation  url="home.cfm">
        <cfelse>
            <cfquery name="addGoogle">
                insert into users (
                    email, 
                    userName, 
                    userImage
                    ) 
                    values(
                    <cfqueryparam value='#arguments.googleStruct.other.email#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.googleStruct.other.given_name#' cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value='#arguments.googleStruct.other.picture#' cfsqltype="CF_SQL_VARCHAR">
                )
            </cfquery>
            <cfquery name="sessionId">
                select userId from users where email = <cfqueryparam value='#arguments.googleStruct.other.email#' cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            <cfset session.userId = sessionId.userId>
            <cfset session.user = arguments.googleStruct.other.given_name>
            <cfset session.userImage = arguments.googleStruct.other.picture>
            <cfset session.email = arguments.googleStruct.other.email>
            <cflocation  url="home.cfm">
        </cfif>
    </cffunction>

    <cffunction  name="birthday" access="remote">
        <cfset local.today = dateFormat(now(), "mm/dd")>
        <cfset local.birthdayToday= "">
        <cfquery name="findBirthday">
            select 
                fname, 
                email, 
                dob 
            from contacts
        </cfquery>
        <cfif findBirthday.recordcount GT 0>
            <cfloop query="findBirthday">
                <cfif dateFormat(findbirthday.dob, "mm/dd") EQ "#local.today#">
                    <cfmail  from="jayasooryakj420@gmail.com"  subject="Happy Birthday #findBirthday.fname# !!"  to="#findBirthday.email#">
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
</cfcomponent>