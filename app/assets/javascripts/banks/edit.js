var EditBank = EditBank || {}
EditBank.pageLoaded = function(){
  this.initialize();
}
EditBank.pageLoaded.prototype= {
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
			  var data = result.bank;
			  $("#BankId").val(data.id);
			  $("#BankName").val(data.name);
			  $("#ContactNo").val(data.contact_no);
		  }
	  });
  },
  updateData:function(){
    $(".form .submit").click(function(){
    	var id=$(".form #BankId").val();
    	var name=$(".form #BankName").val();
    	var contact_no=$(".form #ContactNo").val();
	    var bank = {bank:{"name":name,"contact_no":contact_no}};
	    $.ajax({
		    type: "PUT",
		    url: "/banks/"+id,
		    data: bank,
		    format:"JSON",
		    success: function(result){
			    window.open("/banks","_self");
		    },
		    error: function (result) {
          alert("Error");
        }
	    });
    });
  },  
}