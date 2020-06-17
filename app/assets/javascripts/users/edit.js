var EditUser = EditUser || {}
EditUser.pageLoaded = function(){
  this.initialize();
}
EditUser.pageLoaded.prototype= {
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
			  var data = result.user;
			  $("#BranchId").val(data.branch_id);
			  $("#UserId").val(data.id);
			  $("#UserName").val(data.name);
			  $("#FatherName").val(data.father_name);
			  $("#MotherName").val(data.mother_name);
			  $("#UserAddress").val(data.address);
			  $("#Age").val(data.age);
			  $("#ContactNo").val(data.contact_no);
		  }
	  });
  },
  updateData:function(){
    $(".newuser .submit").click(function(){
			var id = $(".newuser #UserId").val();
			var branchid=$(".newuser #BranchId").val();
			var name=$(".newuser #UserName").val();
			var fathername=$(".newuser #FatherName").val();
			var mothername=$(".newuser #MotherName").val();
			var address=$(".newuser #UserAddress").val();
			var age=$(".newuser #Age").val();
			var contact_no=$(".newuser #ContactNo").val();
	    var user = { "user":{"name":name,"father_name":fathername,"mother_name":mothername,"address":address,"age":age,"contact_no":contact_no}};
	    $.ajax({
		    type: "PUT",
	      url: "/users/"+id,
	   	  dataType: "json",
	      data: user,
		    success: function(result){
		      window.open("/branches/"+branchid,"_self");
	      }
	    });
    });
  },  
}