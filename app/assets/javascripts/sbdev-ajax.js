var History = window.History;
var ajaxed = true;

$.ajaxSetup({
  dataType: "html"
});

function ajax_complete_defaults(data){
  alert('foo');
  $("#main").removeClass('ajax-loader');
  $("#main").html(data);
  $('title').html($("#content_for_title").html());
  $("meta[name='description']").attr("content",$("#content_for_page_description").html());
  $("meta[name='keywords']").attr("content",$("#content_for_keywords").html());
  $('#sidebar').html($("#content_for_sidebar").html());
  $("#content_for_gallery").appendTo('#main');
  $('#slideshow').html($("#content_for_slideshow").html());
  bind_functions("#main");
}

$(document).ready(function (){
  $("a[data-remote]").live('ajax:before', function() {
    $("#main").addClass('ajax-loader');
  });

  $("a[data-remote]").live('ajax:complete', function(status, xhr) {
    ajaxed = true;
    History.pushState(null,'',$(this).attr('href'));
    ajax_complete_defaults(xhr.responseText);
  });

  $(window).bind('statechange',function(){
    if (ajaxed === false ) {
      var url = History.getState().url.replace(History.getRootUrl(),'');
      $.ajax({
        url: url,
        success: [function(data) {History.pushState(null,'',url)},function(data) {ajax_complete_defaults(data);}] 
      });
    } else {
      ajaxed = false;
    }
  });

});
