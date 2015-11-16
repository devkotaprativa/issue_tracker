$(document).on("page:change  ",function(){
  $('.datepicker').datepicker({
  	 orientation: "top",
  	 autoclose: true,
  	 todayHighlight: true,
  	 format: "dd/mm/yyyy"
  });

});