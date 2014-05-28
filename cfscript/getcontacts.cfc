<cfscript>

	/**
	*
	* @file  cfscript/getcontacts.cfc
	* @author  Matt Jones
	* @description	Retrieve contact list from PushBullet API
	*
	*/
	
	component {
	
		remote any function getList() returnFormat='JSON' {

			var h = new http();
			h.setURL('https://api.pushbullet.com/v2/contacts');
			h.setMethod('GET');
			h.setUsername('APIKEY');
			h.setPassword('');
			h.setResolveURL('true');
			result = h.send().getPrefix();

			return #DeSerializeJSON(result.FileContent)#;
		}
	}

</cfscript>
