class Quota.Views.Edit_ContactPhones extends Backbone.View

	# template: HandlebarsTemplates['contacts/edit_contact_phones'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# 
	tagName: 'ul'
	className: 'unstyled form-vertical'
	
	initialize: ->
		@collection.on('reset', @render, @)
		@_phoneViews = [];
		
	render: ->
		$(@el).html('')
		@_phoneViews.push(new Quota.Views.ContactPhone({model:phone, tagName:'li', className:'contact_phone'})) for phone in @collection.models
		if @_phoneViews.length != 0
			$(@el).prepend(dv.render().el) for dv in @_phoneViews
		else
			@collection.setup_new()
		@