class Quota.Views.ShowOpportunityFormAddContact extends Quota.Views.SidebarBodyBlock

	template: HandlebarsTemplates['opportunities/show_opp_form_add_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		@vent.on('add_contact:clicked', @showAddContact, @)
		@vent.on('done_add_contact:clicked', @hideAddContact, @)
		@opportunity = options.parent_model
		
		
	render: ->
		$(@el).html(@template({opportunity:@opportunity}))
		# @hide()
		@
		
	show: ->
		$(@el).toggle(true)
		
	hide: ->
		$(@el).toggle(false)
		
	showAddContact: ->
		@show()
		
	hideAddContact: ->
		@hide()
