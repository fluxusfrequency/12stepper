// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/override
//= require ckeditor/init
//= require bootstrap.min
//= require jquery-ui
//= require scrollTo
//= require_tree .

$.expr[":"].Contains = $.expr.createPseudo(function(arg) {
  return function( elem ) {
    return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
  };
});

var entrySearchAndHighlight = function(searchTerm) {
  if (searchTerm === " ") { return ; }
  $('.highlighted').removeClass('highlighted');
  $("#entry-list-container #entry-index-item-body:contains('"+searchTerm+"')").html($('#entry-list-container #entry-index-item-body').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));
  $("#entry-list-container .entry-item-title a:contains('"+searchTerm+"')").html($('#entry-list-container .entry-item-title a').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));

  if($('.highlighted:first').length) {
    $('html').scrollTop($('.highlighted:first').offset().top);
  }
};

var bigbookSearchAndHighlight = function(searchTerm) {
  $('.highlighted').removeClass('highlighted');
  $("#chapter-view-panel:contains('"+searchTerm+"')").html($('#chapter-view-panel').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));
  
  if($('.highlighted:first').length) {
    $('html').scrollTop($('.highlighted:first').offset().top);
  }
};

$(function(){
    setTimeout($(".cke_bottom").css('margin-top', "220px"), 1000);
  });
