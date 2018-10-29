var EditAccount = EditAccount || {}
EditAccount.pageLoaded = function(){
  this.initialize();
}
EditAccount.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.updateData();    
  },
  getData:function(){
	  $.ajax({
      type: "GET",
	    url: window.location.href,
		  dataType: "json",
		  success: function(result){
			  var data = result.account;
			  $("#UserId").val(data.user_id);
			  $("#AccountId").val(data.id);
			  $("#AccountNo").val(data.account_no);
			  $("#AccountType").val(data.account_type);
			  $("#Balance").val(data.balance);
		  }
	  });
  },
  updateData:function(){
    $(".newaccount .submit").click(function(){
      var id = $(".newaccount #AccountId").val();
			var userid=$(".newaccount #UserId").val();
			var accounttype=$(".newaccount #AccountType").val();
			var accountno=$(".newaccount #AccountNo").val();
			var balance=$(".newaccount #Balance").val();
	    var account = { "account":{"account_no":accountno,"account_type":accounttype,"balance":balance}};
	    $.ajax({
		    type: "PUT",
		    url: "/accounts/"+id,
	      dataType: "json",
	      data: account,
		    success: function(result){
			    window.open("/users/"+userid,"_self");
		    }
      });
    });
  },  
}