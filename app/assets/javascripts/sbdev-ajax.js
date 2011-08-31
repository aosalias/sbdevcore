var History = window.History;
var ajaxed = true;

$.ajaxSetup({
  dataType: "html"
});

function ajax_complete_defaults(data){
  $("#main").removeClass('ajax-loader');
  $("#main").html(data);
  bind_functions("#main");
  $('title').html($("#content_for_title").html());
  $("#content_for_title").remove();
  $("meta[name='description']").attr("content",$("#content_for_page_description").html());
  $("#content_for_page_description").remove();
  $("meta[name='keywords']").attr("content",$("#content_for_keywords").html());
  $("#content_for_keywords").remove();
  $('#sidebar').html($("#content_for_sidebar").html());
  $("#content_for_sidebar").remove();
}

$(document).ready(function (){
  $("a[data-remote]").live('ajax:before', function() {
    $("#main").addClass('ajax-loader');
  });

  $("a[data-remote]").live('ajax:complete', function(status, xhr) {

    ajax_complete_defaults("#main",xhr.responseText);
    $($(this).closest('div')).find('.current').removeClass('current');
    $(this).addClass('current');
    ajaxed = true;
    History.pushState(null,'',$(this).attr('href'));
  });

  $(window).bind('statechange',function(){
    if (ajaxed === false ) {
      var url = History.getState().url.replace(History.getRootUrl(),'');
      $.ajax({
        url: url,
        success: [function(data) {History.pushState(null,'',url)},function(data) {ajax_complete_defaults("#main", data);}] 
      });
    } else {
      ajaxed = false;
    }
  });

});
