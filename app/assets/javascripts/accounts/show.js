 var ShowAccount = ShowAccount || {}
ShowAccount.pageLoaded = function(){
  this.initialize();
}
ShowAccount.pageLoaded.prototype= {
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
			  var accountdata = result.account
			  $("#account .accountno").html("Account No: "+accountdata.account_no);
			  $("#account .accounttype").html("Account Type: "+accountdata.account_type);
			  $(".accountId").val(accountdata.id);
			  $.ajax({
				  type: "GET",
				  url: "/transactions",
				  dataType: "json",
				  success: function(result){
					  var transactiondata = result.transactions;
   				  $.each(transactiondata, function (i, item) {
   					  if(item.account_id == accountdata.id){
	     				  var row = '<tr id="transaction'+item.id+'" ><td> ' + item.transaction_type + ' </td> <td> ' + item.amount + ' </td> <td> <button class="button show usershow" value="'+item.id+'">Show</button></td><td><button class="button edit" value="'+item.id+'">Edit</button></td><td><button class="button delete" value="'+item.id+'">Delete</button></td> </tr>';
	     				  $("#transactions .list").append(row);
	     			  }
   				  });
   			  }
   			});   		
	  	}
		});
		$.ajax({
   		type:"GET",
   		url:"/atms",
   		dataType:"json",
   		success:function(result){
        var atmdata=result.atms
        $.each(atmdata, function(i, item){
          $(".newtransaction #Atm").append('<option value="'+item.id+'">'+item.name+'</option>');
        });
   		}  
   	});
	},
	postData:function(){
		$(".newtransaction .submit").click(function(){
		  var id = $(".newtransaction .accountId").val();
			var transactiontype=$(".newtransaction #TransactionType").val();
			var amount=$(".newtransaction #Amount").val();
			var atmid=$(".newtransaction #Atm").val();
	    var txn = { "transaction":{"account_id":id,"transaction_type":transactiontype,"amount":amount,"atm_id":atmid}};
	    $.ajax({
		    type: "POST",
		    url: "/transactions/",
	   	  dataType: "json",
	   	  data: txn,
		    success: function(result){
			    window.open(window.location.href,"_self");
		    }
	     });
    });    
	},	
	linkShowNewDelete:function(){		
    $(document).on('click','.usershow', function(){
      var id= $(this).val();
      window.open("/users/"+id,"_self")
    });
  },
}