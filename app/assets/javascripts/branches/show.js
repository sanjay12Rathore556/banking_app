 var ShowBranch = ShowBranch || {}
ShowBranch.pageLoaded = function(){
    this.initialize();
}
ShowBranch.pageLoaded.prototype= {
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
			var branchdata = result.branch
			$("#branch .name").html("Branch Name: "+branchdata.name);
			$("#branch .address").html("branch address: "+branchdata.address);
			$(".branchId").val(branchdata.id);
			$.ajax({
				type: "GET",
				url: "/users",
				dataType: "json",
				success: function(result){
					var userdata = result.users;
   				$.each(userdata, function (i, item) {
   					if(item.branch_id == branchdata.id){
	     				var row = '<tr id="user'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.father_name + ' </td> <td> ' + item.mother_name + ' </td> <td> ' + item.address + ' </td> <td>' + item.age + '</td> <td>'+item.contact_no+'</td><td> <button class="button show usershow" value="'+item.id+'">Show</button></td><td><button class="button edit useredit" value="'+item.id+'">Edit</button></td><td><button class="button delete userdelete" value="'+item.id+'">Delete</button></td> </tr>';
	     				$("#users .list").append(row);
	     			}
   				});
   			    }
   			 });   
   			
		}
		});
		$(".showbranch #adduser").hide();
	},
	postData:function(){
		$(".newuser .submit").click(function(){
			var id = $(".newuser .branchId").val();
			var name=$(".newuser #UserName").val();
			var fathername=$(".newuser #FatherName").val();
			var mothername=$(".newuser #MotherName").val();
			var address=$(".newuser #UserAddress").val();
			var age=$(".newuser #Age").val();
			var contact_no=$(".newuser #ContactNo").val();
	        var user = { "user":{"branch_id":id,"name":name,"father_name":fathername,"mother_name":mothername,"address":address,"age":age,"contact_no":contact_no}};
	        $.ajax({
		      type: "POST",
		      url: "/users/",
	   	      dataType: "json",
	   	      data: user,
		      success: function(result){
			     window.open(window.location.href,"_self");
			     $(".showbranch #adduser").show();
		      }
	        });
        });
        
	},	
	linkShowNewDelete:function(){		
       $(document).on('click','.usershow', function(){
        var id= $(this).val();
        window.open("/users/"+id,"_self")
      });
       $(".showbranch #usernew").click(function(){
       	$(".showbranch #adduser").toggle();
       });
       $(document).on('click','.useredit', function(){
    	var id= $(this).val();
	    window.open("/users/"+id+"/edit","_self")
      });
        $(document).on('click','.userdelete', function(){
        if(confirm("are you sure!")){
		  var id=$(this).val();
		  $.ajax({
			type: "DELETE",
			url: "/users/"+id,
			dataType: "json",
			success: function(result){
				$("#user"+id).remove();
			}
		  });
	    };
      });

// destroyMember = function(id){
// 	if(confirm("are you sure!")){
// 		$.ajax({
// 			type: "DELETE",
// 			url: "/members/"+id,
// 			dataType: "json",
// 			success: function(result){
// 				$("#member"+id).remove();
// 			}
// 		});
// 	};
// }
},
}