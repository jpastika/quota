class Quota.Views.ShowOpportunityDocuments extends Backbone.View

	# template: HandlebarsTemplates['opportunities/show_opp_documents'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	el: '#documents_container .section-table'
	
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@opportunity = options.parent_model
		
		@_documentsListView = new Quota.Views.ShowOpportunityDocumentsList({model: new Quota.Models.Document(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
			
	render: ->
		# $(@el).html(@template({opportunity:@opportunity.toJSON()}))
		# 
		@container_document_list = @$('.section-table tbody')
		@_documentsListView.setElement(@container_document_list).render()
		@