(function($){
    
    // jQuery autoGrowInput plugin by James Padolsey
    // See related thread: http://stackoverflow.com/questions/931207/is-there-a-jquery-autogrow-plugin-for-text-fields
        
        $.fn.autoGrowInput = function(o) {
			
			$(this).keyup(resizeInput).each(resizeInput);
			
			function resizeInput() {
			    $(this).attr('size', $(this).val().length || 6);
			}
            
            return this;
        };
        
})(jQuery);