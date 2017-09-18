// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require toastr
//= require_tree .

$(document).ready( function(){
  $('#form-users-list-search').on('keyup', function() {
  var query = this.value.toLowerCase();
    $('.form-users-list-item').each(function(i, elem) {
      if (elem.id.toLowerCase().indexOf(query) != -1) {
          $(this).parent().css("display", "table-row");
      }else{
          $(this).parent().css("display", "none");
      }
    });
  });  
});
