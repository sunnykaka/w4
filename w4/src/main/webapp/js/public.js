$(function(){
		function autoHeight(){
		var winHeight = 0,conHeight = 0,topHeight = 0;
		topHeight = $('.top').height();
		winHeight = $(window).height();
		conHeight = (winHeight-topHeight )+ "px";
		$(".boxTable .autoHeit").attr('height',conHeight);
		$(".iframe_box").css("height",conHeight);
	};
	autoHeight();
	window.onresize = autoHeight;
	
	$('.sidbar dt').toggle(
	    function(){
		    $(this).removeClass('close').addClass('open').siblings('dd').show("fast");
		},function(){
		    $(this).removeClass('open').addClass('close').siblings('dd').hide("fast");
		}
	)
	$('.sidbar dt:first').trigger("click");
	
	$('.sidbar dd').click(function(){
	    $(this).addClass('act').siblings('dd').removeClass('act').parent().siblings('dl').children('dd').removeClass('act');
	});
	
	
});