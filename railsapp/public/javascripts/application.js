Rails.home = {};
Rails.home.index = function() {
	$("form#confirmation").submit(function() {
		alert('Isso é um teste!');
	});
};