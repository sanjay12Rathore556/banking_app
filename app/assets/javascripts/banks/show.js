var ShowBank = ShowBank || {}
ShowBank.pageLoaded = function(){
  this.initialize();
}
ShowBank.pageLoaded.prototype= {
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
			  var bankdata = result.bank
			  $("#bank .name").html("Bank Name: "+bankdata.name);
			  $("#bank .phone_no").html("bank phone no: "+bankdata.contact_no);
			  $(".bankId").val(bankdata.id);
			  $.ajax({
				  type: "GET",
				  url: "/branches",
				  dataType: "json",
				  success: function(result){
					  var branchdata = result.branches;
   				  $.each(branchdata, function (i, item) {
   					  if(item.bank_id == bankdata.id){
	     				  var row = '<tr id="branch'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.address + ' </td> <td>' + item.IFSC_code + '</td> <td>'+item.contact_no+'</td><td> <button class="button show branchshow" value="'+item.id+'">Show</button></td><td><button class="button edit branchedit" value="'+item.id+'">Edit</button></td><td><button class="button delete branchdelete" value="'+item.id+'">Delete</button></td> </tr>';
	     				  $("#branches .list").append(row);
	     			  }
   				  });
   			  }
   			});   
   			$.ajax({
   				type: "GET",
   				url: "/atms",
   				dataType: "json",
   				success: function(result){
   					var atmdata = result.atms;
  					$.each(atmdata, function (i, item){
  						if(item.bank_id==bankdata.id){
   	  					var row = '<tr id="atm'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.address + ' </td><td><button class="button show atmshow" value="'+item.id+'">Show</button></td><td><button class="button edit atmedit" value="'+item.id+'">Edit</button></td><td><button class="button delete atmdelete"  value="'+item.id+'">Delete</button></td> </tr>';
   						  $("#atms .list").append(row);
   						}
   					});
   				}
   			});	
		  }
		});
		$(".bankshow #addbranch").hide();
		$(".bankshow #addatm").hide();
	},
	postData:function(){
		$(".newbranch .submit").click(function(){
			var id = $(".newbranch .bankId").val();
			var name=$(".newbranch #BranchName").val();
			var address=$(".newbranch #BranchAddress").val();
			var IFSC_code=$(".newbranch #IFSC_code").val();
			var contact_no=$(".newbranch #ContactNo").val();
	    var branch = { "branch":{"bank_id":id,"name":name,"address":address,"IFSC_code":IFSC_code,"contact_no":contact_no}};
	    $.ajax({
		    type: "POST",
		    url: "/branches/",
	   	  dataType: "json",
	   	  data: branch,
		    success: function(result){
		    	$(".bankshow #addbranch").hide();
			    window.open(window.location.href,"_self");
		    }
	    });
    });
    $(".newatm .submit").click(function(){
			var id = $(".newatm .bankId").val();
			var name=$(".newatm #AtmName").val();
			var address=$(".newatm #AtmAddress").val();
	    var atm = { "atm":{"bank_id":id,"name":name,"address":address}};
	    $.ajax({
		    type: "POST",
		    url: "/atms/",
	   	  dataType: "json",
	   	  data: atm,
		    success: function(result){
		    	$(".bankshow #addatm").hide();
			    window.open(window.location.href,"_self");
		    }
	    });
    });
	},	
	linkShowNewDelete:function(){
	  $(document).on('click','.branchedit', function(){
    	var id= $(this).val();
	    window.open("/branches/"+id+"/edit","_self")
    });
    $(document).on('click','.atmedit', function(){
    	var id= $(this).val();
	    window.open("/atms/"+id+"/edit","_self")
    });		
    $(document).on('click','.branchshow', function(){
      var id= $(this).val();
      window.open("/branches/"+id,"_self")
    });
    $(document).on('click','.atmshow', function(){
      var id= $(this).val();    
      window.open("/atms/"+id,"_self")
    });
    $(".bankshow #branchnew").click(function(){
      $(".bankshow #addbranch").toggle();
    });
    $(".bankshow #atmnew").click(function(){
     	$(".bankshow #addatm").toggle();
    	location.href="#addatm";
    });
    $(document).on('click','.branchdelete', function(){
      if(confirm("are you sure!")){
  		  var id=$(this).val();
	  	  $.ajax({
		    	type: "DELETE",
		    	url: "/branches/"+id,
		    	dataType: "json",
			    success: function(result){
				    $("#branch"+id).remove();
			    }
		    });
	    };
    });
    $(document).on('click','.atmdelete', function(){
      if(confirm("are you sure!")){
		    var id=$(this).val();
		    $.ajax({
			    type: "DELETE",
			    url: "/atms/"+id,
			    dataType: "json",
			    success: function(result){
				    $("#atm"+id).remove();
			    }
		    });
	    };
    });
  },
}