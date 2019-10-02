$(document).ready(function(){	
	$("div.cart-slider").scrollable();
	$("div.featured").scrollable({speed: 200, vertical: true, circular: true});
	$("#carttoggle").click(function () {
		$("#cart").slideToggle("slow");
	});
	$("div.newest").scrollable();
	$("div.newest-divider:last-child  > div.newest-item:last-child").css('border-right','none');
	$("ul.tabs-nav").tabs("div.tabs-panels > div.tabs-panel");
	$(".round").hover(function(){$(this).addClass("roundon")},function(){$(this).removeClass("roundon")});
	$(".icon-item").hover(
		function(){
			$(this).addClass("hovered");
			$(".hovered > .icon-description").fadeIn();
		},
		function(){
			$(this).removeClass("hovered");
			$(".icon-description").fadeOut();
		}
	);
	$("table.payment tr td:first-child").addClass("td-first");
	$("table.payment tr td:nth-child(2)").addClass("td-second");
	$("table.payment tr td:nth-child(3)").addClass("td-third");
	$("table.payment tr td:nth-child(4)").addClass("td-fourth");
});