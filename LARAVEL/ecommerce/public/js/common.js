
function deleteRecord(url){
	var confirm = window.confirm('Do you really want to delete this record ?');
	if(confirm){
		location.href = url;
	}
}