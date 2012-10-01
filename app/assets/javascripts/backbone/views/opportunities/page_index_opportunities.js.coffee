class Quota.Views.PageIndexOpportunities extends Backbone.View
	
	template: HandlebarsTemplates['opportunities/page_index_opportunities'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	
	# events:
	# 		# "blur .contact_name input": "contactNameChanged"
	# 		# 		"blur .contact_title input": "contactTitleChanged"
	# 		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		@opportunities = options.opportunities
		@vent.on('opportunity_link:clicked', @opportunityLinkClicked, @)
		
	render: ->
		$(@el).empty()
		$(@el).html(@template())
		view = new Quota.Views.IndexOpportunities({collection: @opportunities, vent: @vent})
		@$('#opportunities').append(view.render().el)
		@
	
	opportunityLinkClicked: (evt) ->
		# enablePushState = true  
		# 		pushState = !!(enablePushState and window.history and window.history.pushState)
		# 		if pushState
		# 			# gon.contact = evt.view.model
		# 			Backbone.history.navigate("contacts/" + evt.view.model.get("pub_key") + "/edit", {trigger: true, replace: false})
		# 		else
		window.location.replace('/opportunities/'+evt.view.model.id)