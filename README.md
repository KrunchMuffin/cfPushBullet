Changelog:
* 28/05/2014
	- Added file push cfc

PushBullet is a fantastic app to quickly & easily transfer files from your computer to your mobile device, as well as notes, links, lists & addresses.
Since the API release, I have intregrated this service into many personal and work related projects. However, I needed something in coldfusion to work with a bespoke CMS but there was nothing available. To my knowledge this is the first coldfusion wrapper for the PushBullet API.

Example AJAX call:

```javascript
function pushThis(filePath){
	$.ajax({
		url: 'cfc/pushbullet.cfc?method=pushFile',
		type: 'POST',
		data: { file: filePath },
	})
}
```
