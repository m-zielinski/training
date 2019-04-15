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
//= require_tree .

$(function(){
    $('.movies').children().each(function() {
      var movie_id = $(this).attr("class").split("_")[1];
      $.get( "/api_proxy/" + movie_id, function( data ) {
        var tr = $(".movie_" + movie_id);
        tr.find('.rating .badge').html(data["rating"]);
        tr.find('.plot').html(data["plot"]);
        tr.find('.poster').attr("src", data["poster"]);
      });
    });

    $(".thread_new_comment_link a").hide().click();
});
