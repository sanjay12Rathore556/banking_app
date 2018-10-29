var AddBank = AddBank || {}
AddBank.pageLoaded = function(){
    this.initialize();
}
AddBank.pageLoaded.prototype= {
    initialize:function(){
        this.postData();       
    },
 postData:function(){
   $("#NewBank #Submit").click(function(){
	var name= $("#NewBank #BankName").val();
	var contact_no= $("#NewBank #ContactNo").val();
   var bank={bank:{"name":name,"contact_no":contact_no}};
	$.ajax({
      type: "POST",
      url: "/banks/",
      format: "JSON",
      data: bank,
      success:function(result){
         console.log(result);
         window.open("/banks","_self")
      }
	});
 });
},
}