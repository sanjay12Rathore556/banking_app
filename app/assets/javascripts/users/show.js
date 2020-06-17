var ShowUser = ShowUser || {}
ShowUser.pageLoaded = function(){
  this.initialize();
}
ShowUser.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.linkShowNewDelete();
    this.postData();
  },
  getData:function(){
	  $.ajax({
	  	type: "GET",
		  url: window.location.href,
		  dataType: "json",
		  success: function(result){
			  var userdata = result.user
			  $("#user .name").html("User Name: "+userdata.name);
			  $("#user .address").html("user address: "+userdata.address);
			  $(".userId").val(userdata.id);
			  $.ajax({
				  type: "GET",
				  url: "/accounts",
				  dataType: "json",
				  success: function(result){
				  	var accountdata = result.accounts;
   			  	$.each(accountdata, function (i, item) {
   				  	if(item.user_id == userdata.id){
	     			  	var row = '<tr id="account'+item.id+'" ><td> ' + item.account_no + ' </td> <td> ' + item.account_type + ' </td> <td> ' + item.balance + ' </td><td> <button class="button show accountshow" value="'+item.id+'">Show</button></td><td><button class="button edit accountedit" value="'+item.id+'">Edit</button></td><td><button class="button delete accountdelete" value="'+item.id+'">Delete</button></td> </tr>';
	     				  $("#accounts .list").append(row);
	     			  }
   				  });
   			  }
   			});   
   			$.ajax({
   				type: "GET",
   				url: "/loans",
   				dataType: "json",
   				success: function(result){
   					var loandata = result.loans;
  					$.each(loandata, function (i, item){
  						if(item.user_id==userdata.id){
   	  					var row = '<tr id="loan'+item.id+'" ><td> ' + item.loan_type + ' </td> <td> ' + item.amount + ' </td><td> ' + item.interest + ' </td><td> ' + item.time_period + ' </td><td><button class="button show loanshow" value="'+item.id+'">Show</button></td><td><button class="button edit loanedit" value="'+item.id+'">Edit</button></td><td><button class="button delete loandelete"  value="'+item.id+'">Delete</button></td> </tr>';
   						  $("#loans .list").append(row);
   						}
   					});
   				}
   			});	
		  }
		});
		$(".usershow #addaccount").hide();
		$(".usershow #addloan").hide();
	},
	postData:function(){
		$(".newaccount .submit").click(function(){
			var id = $(".newaccount .userId").val();
			var accounttype=$(".newaccount #AccountType").val();
			var accountno=$(".newaccount #AccountNo").val();
			var balance=$(".newaccount #Balance").val();
	    var account = { "account":{"user_id":id,"account_no":accountno,"account_type":accounttype,"balance":balance}};
	    $.ajax({
		    type: "POST",
		    url: "/accounts/",
	   	  dataType: "json",
	   	  data: account,
		    success: function(result){
		      $(".usershow #addaccount").show();
			    window.open(window.location.href,"_self");
		    }
	    });
    });
    $(".newloan .submit").click(function(){
			var id = $(".newloan .userId").val();
			var loantype=$(".newloan #LoanType").val();
			var amount=$(".newloan #Amount").val();
			var interest=$(".newloan #Interest").val();
			var timeperiod=$(".newloan #TimePeriod").val();
	    var loan = { "loan":{"user_id":id,"loan_type":loantype,"amount":amount,"interest":interest,"time_period":timeperiod}};
	    $.ajax({
		    type: "POST",
		    url: "/loans/",
	   	  dataType: "json",
	   	  data: loan,
		    success: function(result){
		      $(".usershow #addloan").show();
			    window.open(window.location.href,"_self");
		    }
	    });
    });
	},	
	linkShowNewDelete:function(){		
    $(document).on('click','.accountshow', function(){
      var id= $(this).val();
      window.open("/accounts/"+id,"_self")
    });
    $(document).on('click','.loanshow', function(){
      var id= $(this).val();
      window.open("/atms/"+id,"_self")
    });
    $(".usershow #newaccount").click(function(){
      $(".usershow #addaccount").toggle();
    });
    $(".usershow #newloan").click(function(){
      $(".usershow #addloan").toggle();
    });
    $(document).on('click','.accountedit', function(){
    	var id= $(this).val();
	    window.open("/accounts/"+id+"/edit","_self")
    });
    $(document).on('click','.loanedit', function(){
    	var id= $(this).val();
	    window.open("/loans/"+id+"/edit","_self")
    });
    $(document).on('click','.accountdelete', function(){
      if(confirm("are you sure!")){
	  	  var id=$(this).val();
	      $.ajax({
			    type: "DELETE",
			    url: "/accounts/"+id,
			    dataType: "json",
			    success: function(result){
				    $("#account"+id).remove();
			    }
		    });
	    };
    });
    $(document).on('click','.loandelete', function(){
      if(confirm("are you sure!")){
		    var id=$(this).val();
		    $.ajax({
			    type: "DELETE",
			    url: "/loans/"+id,
			    dataType: "json",
			    success: function(result){
				    $("#loan"+id).remove();
			    }
		    });
	    };
    });
  },
}