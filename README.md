**Changelog:**

**28/05/2014**
- Added cfscript file for pushing file to device
- Added cfscript files for retrieving device & contact list 
- Added pushbullet.cfc (currently only for pushing files)

**Introduction**

PushBullet is a fantastic app to quickly & easily transfer files from your computer to your mobile device, as well as notes, links, lists & addresses.

cfPushBullet was born out of nessecity for a pure ColdFusion solution to interface with PushBullet. To my knowledge this is the first ColdFusion wrapper for the PushBullet API.

**Examples**

Example AJAX call for sending files:

```javascript
function pushThis(filePath, dev_id){
	$.ajax({
		url: 'cfc/pushbullet.cfc?method=pushFile',
		type: 'POST',
		data: { file: filePath, deviceIden: dev_id },
	})
}
```
Example AJAX call for showing devices:

```javascript
$(function(){
	$.ajax({
		url: 'cfscript/getdevices.cfc?method=getList',
		type: 'GET',
		dataType: 'JSON',
		success: function(data){
			console.log(data);
		}
	})
})
```
Example AJAX call for showing contacts:

```javascript
$(function(){
	$.ajax({
        	url: 'cfscript/getcontacts.cfc?method=getList',
		type: 'GET',
		dataType: 'JSON',
		success: function(data){
			console.log(data);
		}
	})
})
```
