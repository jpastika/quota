class Quota.Views.ShowOpportunitySidebar extends Quota.Views.SidebarBodyBlock

	template: HandlebarsTemplates['opportunities/show_opp_sidebar'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@_appFieldsView = new Quota.Views.ShowOpportunitySidebarFieldsApp({parent_model:@model, parent_child_key: @model.get("pub_key"), vent: @vent})
		@_customFieldsView = new Quota.Views.ShowOpportunitySidebarFieldsCustom({parent_model:@model, parent_child_key: @model.get("pub_key"), vent: @vent})
		
	render: ->
		$(@el).html(@template({opportunity:@model.toJSON()}))
		@container_app_fields = @$('#sidebar_app_fields_container')
		@container_custom_fields = @$('#sidebar_custom_fields_container')
		
		@_appFieldsView.setElement(@container_app_fields).render()
		@_customFieldsView.setElement(@container_custom_fields).render()
		@
