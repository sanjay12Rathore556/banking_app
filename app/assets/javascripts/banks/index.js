var Banks = Banks || {}
Banks.pageLoaded = function(){
  this.initialize();
}
Banks.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.linkShowDeleteNew();    
  },
  getData:function() {
	  $.ajax({
 		  type: "GET",
 		  url: "/banks",
 		  dataType: "json",
 		  success: function(result){
        var data = result.banks;
   		  $.each(data, function (i, item) {
     		  var row = '<tr id="bank'+item.id+'" ><td> ' + item.name + ' </td><td>' + item.contact_no + '</td><td><button class="button show" value="'+item.id+'">Show</button></td><td><button class="button edit" value="'+item.id+'">Edit</button></td><td><button class="button delete" value="'+item.id+'">Delete</button></td> </tr>';
     		  $(".index #list").append(row);
   		  });
 		  },
 		  error: function (result) {
        alert("Error");
      }
    });     
	},
  linkShowDeleteNew:function() {
    $(document).on('click','.edit', function(){
    	var id= $(".edit").val();
	    window.open("/banks/"+id+"/edit","_self")
    });
    $(document).on('click','.show', function(){
      var id= $(this).val();
      window.open("/banks/"+id,"_self")
    });
    $(".index .new").click(function(){
    	window.open("/banks/new","_self")
    });
    $(document).on('click','.delete', function(){
      if(confirm("are you sure!")){
		    var id=$(this).val();
		    $.ajax({
			    type: "DELETE",
			    url: "/banks/"+id,
			    dataType: "json",
			    success: function(result){
				    $("#bank"+id).remove();
			    }
		    });
	    };
    });
  },
}