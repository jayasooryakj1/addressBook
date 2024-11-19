<cfcomponent>
    
    <cfset this.sessionmanagement="true">
    <cfset this.datasource = "dataSource1">

    <!---<cffunction  name="onRequest">
        <cfargument  name="requestedpage">
        <cfset local.excludedPages=["/addressBook/index.cfm","/addressBook/signup.cfm"]>
        <cfif arrayFind(local.excludedPages,arguments.requestedpage)>
            <cfinclude  template="#arguments.requestedpage#">
        </cfif>
        <cfif structKeyExists(session, "user")>
            <cfinclude  template="#arguments.requestedpage#">
        <cfelse>
            <cflocation  url="index.cfm">
        </cfif>
    </cffunction>--->

</cfcomponent>