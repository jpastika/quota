class Quota.Routers.Documents extends Backbone.Router
	routes:
		'documents/:id': 'show'
		'documents/:id/edit': 'edit'
		'opportunities/:id': 'index'
	
	initialize: ->
	
		
	index: ->
		#alert "home page"
		
	show: (id) ->
		#alert "Quote #{id}"
		
	edit: (id) ->
		@document = new Quota.Models.Document({'pub_key':id})
		@document.fetch()
		view_document_name = new Quota.Views.Edit_Document_Name({model:@document})
		view_document_title = new Quota.Views.Document_Title({model:@document})
		$('#document_name').html(view_document_name.render().el)
		$(document).attr('title',view_document_title.render().el)