class Quota.Views.ShowOpportunityDocuments extends Backbone.View

	template: HandlebarsTemplates['opportunities/show_opp_documents'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@opportunity = options.parent_model
			
	render: ->
		$(@el).html(@template({opportunity:@opportunity.toJSON()}))
		
		@
	
	rendered: ->
