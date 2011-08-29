$.ajaxSetup({
 dataType: "html"
});
$(document).ready(function (){
  $("a[data-remote]").live('ajax:before', function() {
    $($(this).attr('rel')).addClass('ajax-loader');
  });

  $("a[data-remote]").live('ajax:complete', function(status, xhr) {
    $($(this).attr('rel')).removeClass('ajax-loader');
    $($(this).attr('rel')).html(xhr.responseText);
    bind_functions($(this).attr('rel'));
  });
});
