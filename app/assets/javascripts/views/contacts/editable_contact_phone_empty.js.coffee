class Quota.Views.EditableContactPhoneEmpty extends Backbone.View

	template: HandlebarsTemplates['contacts/editable_contact_phone_empty'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	events:
		"click .contact_method_val": "valClicked"
		"click .contact_method_name": "nameClicked"
		# "keyup .contact_method_val": "val_keyup"
		# "keydown .contact_method_val": "val_keydown"
	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@model.on('change', @render, @)
		@model.on('destroy', @remove, @)
		
	render: ->
		$(@el).html(@template({contact_phone:@model.toJSON()}))
		@
		
	valClicked: (evt) ->
		console.log $(evt.target).val()
		
	nameClicked: (evt) ->
		console.log $(evt.target).val()
		
	# val_keyup: (evt) ->
	# 		self = this
	# 		# if $(evt.target).val().length == 1
	# 		# 			@vent.trigger('contact_method_phone_empty:not_empty')
	# 		if $(evt.target).val().length == 0
	# 			@vent.trigger('contact_method_phone_empty:empty')
	# 	
	# 	val_keydown: (evt) ->
	# 		self = this
	# 		if $(evt.target).val().length == 0
	# 			@vent.trigger('contact_method_phone_empty:not_empty')