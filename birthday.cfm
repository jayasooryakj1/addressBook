<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <body>
        <cfobject component="components.addressBook" name="birthdayService">
        <cfset birthdayService.birthday()>
        <cfschedule 
            action="update" 
            task="birthday" 
            operation="HTTPRequest"
            url="http://addressbook.org/birthday.cfm"  
            startDate="#dateFormat(now(), 'yyyy-MM-dd')#"
            <!---endDate="#dateFormat(now(), 'yyyy-MM-dd')#"--->
            file="log.txt" 
            startTime="18:17"  
            interval="10" 
            >
        </cfschedule>
    </body>
</html>