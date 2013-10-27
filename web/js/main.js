$(document).ready(function(){

	$("input[type='text'], input[type='password']").focus(function(){
		$(this).removeClass('error');
	})

	$(".sign-in-btn").click(function(e){
		e.preventDefault();

		var isEmpty = true;
		var notEqual = true;
		var isNotMail = true;
		//check if inputs are empty
		var form = $(".sign-in-form");
		var inputs = $(".sign-in-form input[type='text']");
		var pass = $("#pass");
		var confirmPass = $("#confirm-pass");
		var mail = $("#mail");

		inputs.each(function(){

			if($(this).val() == ""){
				$(this).addClass("error");	
			}else{
				isEmpty = false;
			}
			
		});

		// check if password its equal to confirm password
		if(pass.val() === confirmPass.val() && (pass.val() != "" && confirmPass.val() != "")){
			notEqual = false;
			pass.removeClass('error');
			confirmPass.removeClass('error');
		}else{
			pass.addClass('error');
			confirmPass.addClass('error');
		}

		//check for email
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

		if(mail.val().match(re)){
			isNotMail = false;
		}else{
			mail.addClass("error")
		}

		//check global variables
		if(isEmpty === false && notEqual === false && isNotMail === false){
			form.submit();
			inputs.val("");
		}

	})

});
