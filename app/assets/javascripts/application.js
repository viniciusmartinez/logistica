// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

// plugin jquery.defaultvalue vendors/plugins placeholder attr.
$(function(){
	$(' [placeholder] ').defaultValue();
}

function clear_form_elements(ele) {

    $(ele).find(':input').each(function() {
        switch(this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'textarea':
                $(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });

}

(function($) {
	$.fn.blank=function() {
		return $.trim($(this).val()).length==0;
	}

	$.fn.fadeThenSlideUp = function(speed) {
		return this.fadeTo(speed, 0.00, function(){ //fade
			$(this).slideUp("normal", function(){ //slideup
				$(this).remove(); //then remove from the DOM
			});
		});
	};
})(jQuery);

(function( $ ) {

$( ".ui-autocomplete-input" ).live( "autocompleteopen", function() {
	var autocomplete = $( this ).data( "autocomplete" ),
		menu = autocomplete.menu;

	if ( !autocomplete.options.selectFirst ) {
		return;
	}

	menu.activate( $.Event({ type: "mouseenter" }), menu.element.children().first() );
});

}( jQuery ));

$(document).ready(function() {
	
	// Floating option box
/*	var msie6 = $.browser.msie && parseInt($.browser.version) < 7;
	if (!msie6) {
	  var top = $('.floating_box_wrapper').offset().top - parseFloat($('.floating_box_wrapper').css('margin-top').replace(/auto/, 0));
	  $(window).scroll(function (event) {
	    // what the y position of the scroll is
	    var y = $(this).scrollTop();

	    // whether that's below the form
	    if (y >= top) {
	      // if so, ad the fixed class
	      $('.floating_box_wrapper').addClass('fixed');
	    } else {
	      // otherwise remove it
	      $('.floating_box_wrapper').removeClass('fixed');
	    }
	  });
	}*/
	
	// Formtastic validator
	$('.formtastic').valtastic();
	
	// Tooltip
	$('.tooltip').tipsy({ live: true });
	
	// jQuery RTE
	$(".rich_text").cleditor({
		width: '90%',
		height: 'auto',
		controls: "bold italic underline | bullets numbering | center alignleft alignright justify | undo redo"
	});
	
	// Default values
	$("#search").defaultValue({'value' : 'Pesquisar...'});
	$(".defaultvalue input, .defaultvalue textarea").defaultValue();
	
	// $("select, input:checkbox, input:radio").uniform();
	
	// Remote links
	$(".pagination a").attr('data-remote', 'true');
	
	// Messages disappear
	setTimeout(function(){
		$('.message').fadeOut("normal");
	}, 5000);

	// Select all checkboxes in a table
	$("table #select_all").live("click", function(e){
		$(this).parents("table").find("input[type=checkbox]").attr("checked", $(this).attr("checked"));
	});

	// Selected checkbox changes row class
	$("table input[type=checkbox]").live("click", function(e){
		
	});
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

checked=false;
function checkedAll () {
  var formulario = document.getElementById('formlote');
	if (checked == false)
  {
    checked = true
  }
  else
  {
    checked = false
  }
	for (var i =0; i < formulario.elements.length; i++)
	{
    formulario.elements[i].checked = checked;
	}
}

