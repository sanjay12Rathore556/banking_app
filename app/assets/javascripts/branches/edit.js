var EditBranch = EditBranch || {}
EditBranch.pageLoaded = function(){
    this.initialize();
}
EditBranch.pageLoaded.prototype= {
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
			var data = result.branch;
			$("#BankId").val(data.bank_id);
			$("#BranchId").val(data.id);
			$("#BranchName").val(data.name);
			$("#BranchAddress").val(data.address);
			$("#IFSC_code").val(data.IFSC_code);
			$("#ContactNo").val(data.contact_no);
		}
	  });
    },
    updateData:function(){
      $(".newbranch .submit").click(function(){
      	var bankid=$(".newbranch #BankId").val();
    	var id=$(".newbranch #BranchId").val();
    	var name=$(".newbranch #BranchName").val();
    	var address=$(".newbranch #BranchAddress").val();
    	var IFSC_code=$(".newbranch #IFSC_code").val();
    	var contact_no=$(".newbranch #ContactNo").val();
	    var branch = {branch:{"name":name,"address":address,"IFSC_code":IFSC_code,"contact_no":contact_no}};
	    $.ajax({
		  type: "PUT",
		  url: "/branches/"+id,
		  data: branch,
		  format:"JSON",
		  success: function(result){
			window.open("/banks/"+bankid,"_self");
		  },
		  error: function (result) {
                alert("Error");
          }
	    });
      });
    },  
}