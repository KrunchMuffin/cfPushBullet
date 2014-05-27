<cfcomponent>

	<!--- REQUIRED --->
	<cfset apiURL = 'https://api.pushbullet.com/v2'>
	<cfset apikey = ''>
	<cfset deviceIden = ''>
	
	<cffunction name='pushFile' returntype='void' access='remote'>
		<cfargument name='file' type='string' required='true'>

		<!--- set filename & get mime type --->
		<cfset fileName = getFileFromPath(#arguments.file#)>
		<cfset mimeType = fileGetMimeType(#arguments.file#)>

		<!--- get upload request info --->
		<cfhttp url='#apiURL#/upload-request' method='GET' result='tokenRequest' username='#apikey#' password=''>
			<cfhttpparam name='file_name' type='url' value='#fileName#'>
			<cfhttpparam name='file_type' type='url' value='#mimeType#'>
		</cfhttp>

		<!--- parse the json result --->
		<cfset tokenJSON = DeserializeJSON(tokenRequest.FileContent)>

		<!--- upload the file --->
		<cfhttp url='#tokenJSON.upload_url#' method='POST' multipart='true' result='fileUpload'>
			<cfhttpparam type='header' name='User-Agent' value='cfPushBullet'>
			<cfhttpparam type='formfield' name='acl' value='#tokenJSON.DATA.acl#'>
			<cfhttpparam type='formfield' name='key' value='#tokenJSON.DATA.key#'>
			<cfhttpparam type='formfield' name='signature' value='#tokenJSON.DATA.signature#'>
			<cfhttpparam type='formfield' name='policy' value='#tokenJSON.DATA.policy#'>
			<cfhttpparam type='formfield' name='content-type' value='#mimeType#'>
			<cfhttpparam type='formfield' name='awsaccesskeyid' value='#tokenJSON.DATA.awsaccesskeyid#'>
			<cfhttpparam type='file' name='file' file='#arguments.file#'>
		</cfhttp>

		<!--- push file to device --->
		<cfhttp url='#apiURL#/pushes' method='POST' username='#apikey#' password='' result='done'>
			<cfhttpparam type='formfield' name='type' value='file'>
			<cfhttpparam type='formfield' name='device_iden' value='#deviceIden#'>
			<cfhttpparam type='formfield' name='file_name' value='#fileName#'>
			<cfhttpparam type='formfield' name='file_type' value='#mimeType#'>
			<cfhttpparam type='formfield' name='file_url' value='#tokenJSON.file_url#'>
			<cfhttpparam type='formfield' name='body' value='#mimeType#'>
		</cfhttp>

	</cffunction>

</cfcomponent>
