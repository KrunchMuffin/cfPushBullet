<cfscript>

	/**
	*
	* @file  cfscript/getcontacts.cfc
	* @author  Matt Jones
	* @description	Retrieve contact list from PushBullet API
	*
	*/
	
	component {
	
		/* set your api key - leave in the colon*/
		variables.apikey = ':';
	
		remote any function getList() returnFormat='JSON' {
		
			var b64key = toBase64(#variables.apikey#);

			var h = new http();
			h.setURL('https://api.pushbullet.com/v2/contacts');
			h.setMethod('GET');
			h.addParam(type='header', name='Authorization', value='Basic #b64key#');
			h.setResolveURL('true');
			result = h.send().getPrefix();

			return #DeSerializeJSON(result.FileContent)#;
		}
	}

</cfscript>
