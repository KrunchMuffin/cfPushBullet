Collection of ColdFusion CFC files for the PushBullet v2 API.

Example AJAX call:

```ajax
function pushThis(filePath){
	$.ajax({
		url: 'cfc/pushbullet.cfc?method=pushFile',
		type: 'POST',
		data: { file: filePath },
	})
}
```
