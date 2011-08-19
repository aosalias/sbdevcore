$.tools.tabs.addEffect("myAjax", function(tabIndex, done) {
 $.get(
   this.getTabs().eq(tabIndex).attr('href'),
   {},
   done,
   "script"
 );
});

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
      // First unset it, then set (which otherwise appends)
      xhr.setRequestHeader("Accept", "text/javascript");
    }
});

jQuery.fn.submitWithAjax = function () {
  this.submit(function () {
    $.post($(this).attr('action'), $(this).serialize(), null, "script");
    return false;
  });
};

jQuery.fn.ajaxDelete = function () {
  this.click( function(event) {
    event.preventDefault();
    $.post(
      this.href,
      { _method: 'delete' },
      null,
      'script'
    );
    $(this).closest('li').hide();
  });
  return false;
};

jQuery.fn.ajaxLink = function () {
  this.click( function(event) {
    event.preventDefault();
    if ($(this).hasClass("current")) { return; }
    if($(this).hasClass('button')) {
      $($(this).closest('.ajax-nav')).find('.current').removeClass('current');
      $(this).addClass('current');
    }
    $.get(
      this.href,
      {},
      null,
      "script"
    );
  });
};

jQuery.fn.toggleable = function () {
  this.click( function(event) {
    event.preventDefault();
    if ($(this).hasClass("current")) { return; }
    if($(this).hasClass('button')) {
      $('.toggle_link').removeClass('current');
      $(this).addClass('current');
    }

    $('.toggleable_content').hide();
    $("." + $(this).attr('id')).show();
  });
};

jQuery.fn.highlightDiv = function(){
  var foo = $(this).closest('div');
  $(this).hover(
    function(){
      foo.addClass('highlight-section');
    },
    function(){
      foo.removeClass('highlight-section');
    }
  );
}

function remove_fields(link) {
    $(link).parent().prev("input[type=hidden]").val("1");
    $(link).closest(".nested_fields").hide();
}

function add_nested(link, association, content, hide) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
  if(hide){
    $(link).hide();
  }
  if (content.match(/mceEditor/i)){
    var id = $(".mceEditor", content.replace(regexp, new_id)).attr("id");
    tinyMCE.execCommand('mceAddControl', true, id);
  }
  if (content.match(/date/i)){
    $(".date").dateinput({min: 0, yearRange: [0,2], format: 'ddd, mmmm d, yyyy'});
  }
}

function set_currents(){
  $('#nav [href="'+window.location.pathname.match(/\/\w*/i)+'"]').addClass("current");
  $('#nav [href="'+window.location.pathname+'"]').addClass("current");
  if(window.location.pathname === '/') {
    $('#nav [href="/home"]').addClass("current");
  }
}

function paginateAjax(){
  $('.pagination').children().addClass('button corner-all box-shadow');
}

function setOverlay(){
  $(".overlayed").overlay({

		onBeforeLoad: function() {
			var wrap = this.getOverlay().find(".contentWrap");
			var url = this.getTrigger().attr("href");
      $.ajax({
        url: url,
        async: false,
        dataType: "html",
        type: "GET",
        success: function(data){
          wrap.html(data);
        }
      })
		},

    onLoad: function(){
      setTooltip();
      $(".validate", this.getOverlay).validator({position: "top center",message: '<div><em/></div>', offset: [-17,0]});
      if($('#overlay .mceEditor').length > 0){
        tinyMCE.execCommand('mceAddControl', false, $('.mceEditor').attr('id'));
      }
    },

    onBeforeClose: function(){
      if($('#overlay .mceEditor').length > 0){
        tinyMCE.execCommand('mceFocus', false, $('.mceEditor').attr('id'));
        tinyMCE.execCommand('mceRemoveControl', false, $('.mceEditor').attr('id'));
      }
      this.getOverlay().find(".contentWrap").html("");
      $(".error").hide();
    }
	});
}

function setTooltip(){
 $(".tooltipped").tooltip({layout: "<span/>", position: 'top center', offset: [-15,0], effect: 'fade', opacity: .8});
}

function spellcheck(){
  $('.mceEditor iframe').contents().find('body').attr("spellcheck", true);
}

$(document).ready(function (){
  $('.ajax_form').submitWithAjax();
  $('.ajax_link').ajaxLink();
  $('.ajax_delete').ajaxDelete();
  $('.toggle_link').toggleable();
  $('.toggle_link').first().click();
  $(".scrollable").scrollable();
  $(".validate").validator({position: "top center",message: '<div><em/></div>', offset: [-17,0]});
  $('.asset-admin a').each(function(){
    $(this).highlightDiv();
  }); 
  paginateAjax();
  set_currents();
  setOverlay();
  setTooltip();
  $('.accordion').tabs(".accordion div.pane", {tabs: 'h4', effect: 'fade'})
  $(".items").tabs("#gallery_wrap div", {effect: 'myAjax', history: true, rotate: true}).slideshow({clickable: false, history: true});
  $("#course_nav").tabs("#ajax_content", {effect: 'myAjax', history: true, initialIndex: null});
  $('.overlay .close').click(function(){$(".error").hide();})
});
 