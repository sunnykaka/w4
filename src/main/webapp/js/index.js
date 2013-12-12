$(function(){

	//banner
	var flashTime = flash_n = 0;
	var flash_count = $('.bannerCon li').length;
		
	
	flashTime = setInterval(flash_Auto,5000);
	
	$('.bannerCon li').hover(function()
	{
	    clearInterval(flashTime);
	},function(){
		flashTime = setInterval(flash_Auto,5000);		
		});
		
	function flash_Auto()
	{  
		$('.bannerCon li').eq(flash_n).stop().animate({opacity:1},2000).siblings().stop().animate({opacity:0},2000);
		flash_n = flash_n >= (flash_count - 1) ? 0 : ++flash_n;
	}
	

})