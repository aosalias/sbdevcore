$.tools.tabs.addEffect("myAjax", function(tabIndex, done) {
  $.ajax({
    url: this.getTabs().eq(tabIndex).attr('href'),
    beforeSend: function(){$("#gallery_wrap_inner").addClass('ajax-loader');},
    success: [
      function(data){$('#gallery_wrap_inner').html(data);},
      function(){bind_functions("#gallery_wrap_inner")},
      function(){$("#gallery_wrap_inner").removeClass('ajax-loader');},
      function(){$(this).addClass('current');},
      done
    ]
  });
});

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
};

function set_currents(){
  $(".button").not("#gallery .button").removeClass('current');
  $('[href="'+window.location.pathname.match(/\/\w*/i)+'"]').addClass("current");
  $('[href="'+window.location.pathname+'"]').addClass("current");
  if(window.location.pathname === '/') {
    $('[href="/home"]').addClass("current");
  }
}

function paginateAjax(context){
  $('.pagination', context).children().addClass('button corner-all box-shadow');
}

function setOverlay(context){
  $(".overlayed", context).overlay({
    fixed: false,
    target: '#overlay',
    top: 0,
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
      if($('#overlay .mceEditor').length > 0){
        tinyMCE.execCommand('mceAddControl', false, $('.mceEditor').attr('id'));
      }
      bind_functions("#overlay");
    },

    onBeforeClose: function(){
      if($('#overlay .mceEditor').length > 0){
        tinyMCE.execCommand('mceFocus', false, $('.mceEditor').attr('id'));
        tinyMCE.execCommand('mceRemoveControl', false, $('.mceEditor').attr('id'));
      }
    }
	});
}

function setTooltip(){
 $(".tooltipped").tooltip({layout: "<span/>", position: 'top center', offset: [-15,0], effect: 'fade', opacity: .8});
}

function spellcheck(context){
  $('.mceEditor iframe', context).contents().find('body').attr("spellcheck", true);
}

function fade_flash(){
  setTimeout(function(){$(".flash").slideUp("slow");}, 5000);
}

function bind_slideshow(){
  if(!jQuery.isEmptyObject($('#scrollable_tabs_content'))){
    $("#scrollable_tabs").tabs("#scrollable_tabs_content div", {
      effect:'fade',
      fadeOutSpeed: "slow",
      rotate: true
    }).slideshow({
      autoplay: true,
      autopause: true,
      clickable: true,
      next: '#forward',
      prev: '#backward'
    });
    var api = $("#scrollable_tabs").data("tabs");
    $("#forward").click(function(){api.stop();});
    $("#backward").click(function(){api.stop();});
    var slide_api = $("#scrollable_tabs").data("slideshow");
    $("#pause").click(function(){slide_api.stop();})
    $(window).focus(function() {
      $("#scrollable_tabs").data("slideshow").play();
    });
    $(window).blur(function() {
      $("#scrollable_tabs").data("slideshow").stop();
    });
  }
}

function bind_functions(context){
  $('.asset-admin a', context).each(function(){
    $(this).highlightDiv();
  });
  setOverlay(context);
  spellcheck(context);
  $('form[data-validate]', context).validate();
  set_currents();
  $(".scrollable", context).scrollable();
  $(".items", context).tabs("#gallery_wrap_inner", {effect: 'myAjax', rotate: true}).slideshow({clickable: false});
  bind_slideshow();
  paginateAjax(context);
  fade_flash();
}


$(document).ready(function (){
  bind_functions(document);
  init_tinymce();
});
 