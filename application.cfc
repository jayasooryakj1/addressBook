<cfcomponent>
    
    <cfset this.ormEnabled = true>
    <cfset this.sessionmanagement="true">
    <cfset this.datasource = "dataSource1">

    <cffunction name="onRequest" >
        <cfargument  name="requestedpage">
        <cfset local.excludedPages=["/index.cfm","/signup.cfm", "/googleSignup.cfm", "/birthday.cfm"]>
        <cfif arrayFind(local.excludedPages,arguments.requestedpage)>
            <cfinclude  template="#arguments.requestedpage#">
        <cfelse>
            <cfif structKeyExists(session, "user")>
                <cfinclude  template="#arguments.requestedpage#">
            <cfelse>
                <cflocation  url="index.cfm">
            </cfif>
        </cfif>
    </cffunction>

</cfcomponent>