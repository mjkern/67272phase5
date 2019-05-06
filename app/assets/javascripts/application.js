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
//= require materialize-sprockets
// require materialize-form
//= require vue
//= require_tree .
// require best_in_place

function toggleShipped(url) {
  return function() {
    console.log("toggleing order item " + url);
    $.ajax({
      url: url
    });
  }
}


function toggleItem(url) {
  return function() {
    console.log("toggleing item " + url);
    $.ajax({
      url: url
    });
  }
}

// init everything
$(document).ready(function(){

  ////// vue //////
  var vm = new Vue({
    el: '#tabbed'
  });

  /*
  var toggles = new Vue({
    el: '.toggle'
  });
  */


  ////// materialize //////

  // materialbox
  $('.materialboxed').materialbox();

  // drop downs
  var elems = document.querySelectorAll('.dropdown-trigger');
  var options = {
    coverTrigger: false,
    hover: true
  };
  var instances = M.Dropdown.init(elems, options);

  // collabsible
  var elems = document.querySelectorAll('.collapsible');
  var options = {};
  var instances = M.Collapsible.init(elems, options);

  // select
  var elems = document.querySelectorAll('select');
  var options = {};
  var instances = M.FormSelect.init(elems, options);

  // subtabs
  // select
  var elems = document.querySelectorAll('.subtabs');
  var options = {};
  var instances = M.Tabs.init(elems, options);

  ////// hacky fixes //////

  // for orders index
  $('.pagination a').each(function(a,b){
    if (b.href.match(/\/orders\//)){
      s = b.href.split("?");
      front = s[0].split("/");
      front.pop();
      b.href = [front.join("/"), s[1]].join("?");
    }
  });

});


// for Flash fade - from pats - not my own work
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(4000).fadeOut();
   });
});

