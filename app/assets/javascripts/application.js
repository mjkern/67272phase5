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
//= require jquery
//= require rails-ujs
//= require_tree .
//= require materialize-sprockets
// require materialize-form
//= require vue

// for all materialize components
$( document ).ready(function() {
  M.AutoInit();
  //$('.materialboxed').materialbox();
});

// for Flash fade - from pats - not my own work
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(4000).fadeOut();
   });
});

