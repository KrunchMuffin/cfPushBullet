Changelog:
28/05/2014
- Added cfscript files for retrieving device & contact list 
- Added pushbullet.cfc (currently only for pushing files)

PushBullet is a fantastic app to quickly & easily transfer files from your computer to your mobile device, as well as notes, links, lists & addresses.

To my knowledge this is the first ColdFusion wrapper for the PushBullet API.

Example AJAX call for sending files:

```javascript
function pushThis(filePath){
	$.ajax({
		url: 'cfc/pushbullet.cfc?method=pushFile',
		type: 'POST',
		data: { file: filePath },
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
