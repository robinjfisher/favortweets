function linkify(string) {
	var text = string.replace(/([A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+)/g,"<a href='$1'>$1</a>");
	var text = text.replace(/(@([\w]+))/g,"<a href='http://twitter.com/$2'>$1</a>");
	var text = text.replace(/(#([\w]+))/g,"<a href='http://twitter.com/#search?q=$2'>$1</a>");
	return text
};

$(document).ready(function() {
	
	$(".tweet .tag-form").hide();
	
	$(".edit-tags").click(function() {
		$(this).hide();
		$(this).siblings(".tag").hide();
		$(this).parent().siblings(".tag-form").show();
	});
	
	$(".cancel-tag-edit").click(function() {
		$(this).parents(".tag-form").hide();
		$(this).parent().siblings("p").children().show();
	});
	
	var tweets = $(".tweet-text");
	tweets.each(function() {
		var text = $(this).html();
		var linkifiedText = linkify(text);
		$(this).html(linkifiedText);
	});
	
})