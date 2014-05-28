<cfscript>

	/**
	*
	* @file  cfscript/pushfile.cfc
	* @author  Matt Jones
	* @description	push file to device
	*
	*/
	
	component {

		/* REQUIRED - leave in colon at end of api key variable*/
		variables.apiURL = 'https://api.pushbullet.com/v2';
		variables.apiKey = ':';

		remote void function pushThis(required string file, required string dev_id) {
		
			var b64key = toBase64(#variables.apiKey#);

			var fileName = getFileFromPath(#arguments.file#);
			var mimeType = fileGetMimeType(#arguments.file#);

			/* UPLOAD REQUEST */
			var ur = new http();
			ur.setURL('#variables.apiURL#/upload-request');
			ur.setMethod('GET');
			ur.addParam(type="header", name="Authorization", value="Basic #b64key#");
			ur.addParam(type="url", name="file_name", value="#fileName#");
			ur.addParam(type="url", name="file_type", value="#mimeType#");
			urResult = ur.send().getPrefix();

			var json = #DeSerializeJSON(urResult.FileContent)#;

			/* UPLOAD FILE */
			var uf = new http();
			uf.setURL('#json.upload_url#');
			uf.setMethod('POST');
			uf.setMultipart('true');
			uf.addParam(type="header", name="User-Agent", value="cfPushBullet");
			uf.addParam(type="formfield", name="acl", value="#json.DATA.acl#");
			uf.addParam(type="formfield", name="key", value="#json.DATA.key#");
			uf.addParam(type="formfield", name="signature", value="#json.DATA.signature#");
			uf.addParam(type="formfield", name="policy", value="#json.DATA.policy#");
			uf.addParam(type="formfield", name="content-type", value="#mimeType#");
			uf.addParam(type="formfield", name="awsaccesskeyid", value="#json.DATA.awsaccesskeyid#");
			uf.addParam(type="file", name="file", file="#arguments.file#");
			ufResult = uf.send().getPrefix();

			/* PUSH FILE */
			var pf = new http();
			pf.setURL('#variables.apiURL#/pushes');
			pf.setMethod('POST');
			pf.addParam(type="header", name="Authorization", value="Basic #b64key#");
			pf.addParam(type="formfield", name="type", value="file");
			pf.addParam(type="formfield", name="device_iden", value="#dev_id#");
			pf.addParam(type="formfield", name="file_name", value="#fileName#");
			pf.addParam(type="formfield", name="file_type", value="#mimeType#");
			pf.addParam(type="formfield", name="file_url", value="#json.file_url#");
			pf.addParam(type="formfield", name="body", value="#mimeType#");
			pfResult = pf.send().getPrefix();

		}
	}

</cfscript>
