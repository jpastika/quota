class Quota.Views.SearchResultsCategory extends Backbone.View

	template: HandlebarsTemplates['search/search_results_category'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click input" : "handleClick"
		# "click .icon-remove": "destroy"
		# 		"click .catalog_item_link": "catalogItemLinkClicked"
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@title = options.title
		@cnt = options.cnt
		
	render: ->
		$(@el).html(@template({title:@title, cnt:@cnt}))
		@