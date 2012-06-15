class Quota.Routers.Quotes extends Backbone.Router
	routes:
		'quotes/:id': 'show'
		'quotes/:id/edit': 'edit'
		'opportunities/:id': 'index'
	
	initialize: ->
	
		
	index: ->
		#alert "home page"
		
	show: (id) ->
		#alert "Quote #{id}"
		
	edit: (id) ->
		@quote = new Quota.Models.Quote({'pub_key':id})
		@quote.fetch()
		view_quote_name = new Quota.Views.Edit_Quote_Name({model:@quote})
		view_quote_title = new Quota.Views.Quote_Title({model:@quote})
		$('#quote_name').html(view_quote_name.render().el)
		$(document).attr('title',view_quote_title.render().el)