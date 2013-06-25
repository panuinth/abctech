// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
$(function() {
  $("#search").validate({
    rules:{
      uuid:"required"
    },
    errorClass: "help-inline"
  });

  $("#signup").validate({
    rules:{
      name:"required",
      age: {
        required:true,
        digits: true
      },
      gender:"required"
    },
    errorClass: "help-inline"
  });

   $("#upload-picture").validate({
    rules:{
      uuid:"required",
      fileupload:"required"
    },
    errorClass: "help-inline"
  });

  $("button.btn-gender").click(function() {
    if ($(this).text() == "Male"){
      $("#sex").val("M");
    }else {
      $("#sex").val("F");
    }
  });

});
