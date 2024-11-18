<cfcomponent>

    <cffunction  name="signup" returntype="string">
        <cfargument  name="fullName">
        <cfargument  name="email">
        <cfargument  name="userName">
        <cfargument  name="inputImage">
        <cfargument  name="password">
        <cfset local.uploadLocation = expandPath("./Assets/imageUploads/")>
        <cfset local.imageLink = "#local.uploadLocation##arguments.inputImage#">
        <cfset local.hashedPassword = hash("#arguments.password#", "SHA-256", "UTF-8")>
        <cfquery name="query">
            select count(userName) as count from users where userName=<cfqueryparam value='#arguments.userName#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif query.count GT 0>
            <cfset local.result = "Username already exists">
        <cfelse>
            <cfquery name="insertValues">
                insert into users (fullName, email, userName, userImage, pwd) values(
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
            select count(username) as count from users where userName=<cfqueryparam value= '#arguments.userName#' cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif check.count==0>
            <cfset local.result = "Invalid username">
        <cfelse>
            <cfquery name="pass">
                select pwd from users where userName=<cfqueryparam value='#arguments.userName#'>
            </cfquery>
            <cfif pass.pwd != local.hashedPassword>
                <cfset local.result = "Incorrect password">
            <cfelse>
                <cfset local.result = "true">
                <cfset session.user = arguments.userName>
            </cfif>
        </cfif>
        <cfreturn local.result>
    </cffunction>

</cfcomponent>