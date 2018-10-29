var EditAtm = EditAtm || {}
EditAtm.pageLoaded = function(){
    this.initialize();
}
EditAtm.pageLoaded.prototype= {
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
			var data = result.atm;
			$("#BankId").val(data.bank_id);
			$("#AtmId").val(data.id);
			$("#AtmName").val(data.name);
			$("#AtmAddress").val(data.address);
		}
	  });
    },
    updateData:function(){
      $(".newatm .submit").click(function(){
      	var bankid=$(".newatm #BankId").val();
    	var id=$(".newatm #AtmId").val();
    	var name=$(".newatm #AtmName").val();
    	var address=$(".newatm #AtmAddress").val();
	    var atm = {atm:{"name":name,"address":address}};
	    $.ajax({
		  type: "PUT",
		  url: "/atms/"+id,
		  data: atm,
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