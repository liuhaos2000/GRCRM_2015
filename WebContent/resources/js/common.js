function myalert(message,dom){
	$("#"+dom).append('<div class="alert alert-info my-alert">'+
			message+
			'</div>');
	setTimeout("$('.my-alert').remove()",1500);
	
}






