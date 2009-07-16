// Extensions
;(function($){
	// set focus on the first form field
	$.formFocus = function() {
		$('form:first :text, form:first :password, form:first textarea').eq(0).each(function() {
			this.focus();
		});
	};
	
	// disable submit buttons after they were clicked
	$.disableSubmit = function(text) {
		$(':submit, input.submit')
			.not('.skip')
			.each(function() {
				if (this.title) {
					this.value = this.title;
					$(this).removeAttr('title');
				}
			})
			.click(function() {
				this.disabled = true;
				this.value = text || "Please wait...";
				this.form.submit();
			});
	};
	
	// select a field's content when focusing it
	$.selectFieldOnFocus = function() {
		$(':text, textarea').not('.skip').click(function() {
			this.select();
			return false;
		});
	};
	
	// field counter
	$.maxChars = function(selector, maxlength, message) {
		var parent = $(selector).parent('div,p');
		var form = $(parent).parents('form:first');
		var submit = $(form).find(':submit')[0];
		
		if (!message) {
			message = 'You have %d characters left';
		}
		
		var callback = function() {
			if (this.type != 'textarea') {
				maxlength = $(this).attr('maxlength');
			};
			
			var diff = maxlength - this.value.length;
			var holder = $(parent).find('.chars-left');
			
			$(holder).text(message.replace(/%d/, diff));
			
			if (diff < 0) {
				$(holder).addClass('error');
				submit.disabled = true;
			} else {
				$(holder).removeClass('error');
				submit.disabled = false;
			};
		};
		
		$(selector)
			.keypress(callback)
			.keyup(callback)
			.keydown(callback)
			.trigger('keyup');
	};
})(jQuery);

// Before
Rails.before = function() {
	$.disableSubmit("Aguarde...");
};

// Home
Rails.home = {};
Rails.home.index = function() {
	$("form#confirmation").submit(function() {
		alert('Isso é um teste!');
	});
};