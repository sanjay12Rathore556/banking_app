var ShowAtm = ShowAtm || {}
ShowAtm.pageLoaded = function(){
  this.initialize();
}
ShowAtm.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.linkShowNewDelete();    
  },
  getData:function(){
	  $.ajax({
      type: "GET",
	    url: window.location.href,
	    dataType: "json",
	    success: function(result){
	      var atmdata = result.atm
	      $("#atm .atmname").html("Atm name: "+atmdata.name);
		    $("#atm .atmaddress").html("Address: "+atmdata.address);
		    $(".atmId").val(atmdata.id);
		    $.ajax({
				  type: "GET",
				  url: "/transactions",
				  dataType: "json",
				  success: function(result){
					  var transactiondata = result.transactions;
   				  $.each(transactiondata, function (i, item) {
   					  if(item.atm_id == atmdata.id){
	     				  var row = '<tr id="transaction'+item.id+'" ><td> ' + item.transaction_type + ' </td> <td> ' + item.amount + ' </td><td> </td> <td> <button class="button show transactionshow" value="'+item.id+'">Show</button></td><td><button class="button edit" value="'+item.id+'">Edit</button></td><td><button class="button delete" value="'+item.id+'">Delete</button></td> </tr>';
	     				  $("#transactions .list").append(row);
	     			  }
   				  });
   			  }
   		  });   	
		  }
	  });	
  },
	linkShowNewDelete:function(){		
    $(document).on('click','.atmshow', function(){
      var id= $(".atmshow").val();
      window.open("/atms/"+id,"_self")
    });
  },
}