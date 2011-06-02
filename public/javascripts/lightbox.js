$(document).ready(function() {
  $("a[rel]").overlay({
	mask: {
		color: '#333',
		loadSpeed: 150,
		opacity: 0.9
	},
	closeOnClick: false
  });
  
  $("#sign_in").hide();
  $("#registration #login").click(function(){
     $("#registration").fadeOut({complete:function(){$("#sign_in").fadeIn();}});
  });
  $("#sign_in #register").click(function(){
     $("#sign_in").fadeOut({complete:function(){$("#registration").fadeIn();}});
  });
});

