class Quota.Views.EditCatalogItem extends Backbone.View

	template: HandlebarsTemplates['catalog_items/edit_catalog_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
	# 		"blur #opportunity_estimated_close_dp": "checkEstimatedCloseDate"
	# 		"blur #opportunity_actual_close_dp": "checkActualCloseDate"
	# 		"blur #opportunity_actual_cancel_dp": "checkActualCancelDate"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		Backbone.Validation.bind(
			@
			valid: (view, attr) ->
				self.clearError(attr)
			invalid: (view, attr, error) ->
				self.clearError(attr)
				self.handleError(attr, error)
		)
		@vent = options.vent
		# @milestones = options.milestones
		# 		@companies = options.companies
		# 		@sales_reps = options.sales_reps
		# 		@users = options.users
		# 		@_milestonesView = new Quota.Views.MilestoneSelect({parent_model:@model, parent_child_key: @model.get("milestone_key"), collection:@milestones, field_name:"opportunity[milestone_key]", vent: @vent})
		# 		@_usersView = new Quota.Views.UserSelect({parent_model:@model, parent_child_key: @model.get("owner_key"), collection:@users, field_name:"opportunity[owner_key]", vent: @vent})
		# @_manufacturerComboView = new Quota.Views.ManufacturerComboView({parent_model:@model, collection:@manufacturers, source: "name", val: "name", className: 'string input-xlarge', vent: @vent})
		@model.on('change', @render, @)
		# @vent.on('milestone:changed', @milestoneChanged, @)
		# 		@vent.on('company_name:changed', @companyNameChanged, @)
		@vent.on('catalog_item:rendered', @rendered, @)
		# @vent.on('estimated_close_date:blur', @checkEstimatedCloseDate, @)
		# 		@vent.on('actual_close_date:blur', @checkActualCloseDate, @)
		# 		@vent.on('actual_cancel_date:blur', @checkActualCancelDate, @)
		
	render: ->
		self = @
		$(@el).html(@template({opportunity:@model.toJSON()}))
		
		@catalog_item_name = @$('.catalog_item_name')
		# @opportunity_company_name = @$('.company_name')
		# 		@input_opportunity_name = @$('.opportunity_name input')
		# 		@input_opportunity_company_name = @$('.company_name input')
		# 		@input_opportunity_company_key = @$('.company_key')
		# 		@input_opportunity_milestone_key = @$('.opportunity_milestone_key input')
		# 		@input_opportunity_probability = @$('.opportunity_probability input')
		# 		@input_opportunity_estimated_close = @$('.opportunity_estimated_close input')
		# 		@input_opportunity_estimated_value = @$('.opportunity_estimated_value input').first()
		# 		@input_opportunity_estimated_value_interval = @$('.opportunity_estimated_close select')
		# 		@input_opportunity_owner_key = @$('.opportunity_owner_key select')
		# 		@input_opportunity_actual_close = @$('.opportunity_actual_close input')
		# 		@container_milestones = @$('#milestones')
		# 		@container_users = @$('#users')
		# 		 		
		# 		@opportunity_estimated_close_datepicker_button = @$(".opportunity_estimated_close .icon-calendar")
		# 		@opportunity_actual_close_datepicker_button = @$(".opportunity_actual_close .icon-calendar")
		# 		@opportunity_actual_cancel_datepicker_button = @$(".opportunity_actual_cancel .icon-calendar")
		# 		
		# 		@_milestonesView.setElement(@container_milestones).render()
		# 		
		# 		@container_users.html(@_usersView.render().el)
		# 		
		# 		company_name_field_name = @input_opportunity_company_name.attr('name')
		# 		company_name_field_id = @input_opportunity_company_name.attr('id')
		# 		
		# 		@_companyComboView.setElement(@opportunity_company_name).render()
		# 		# @opportunity_company_name.html(@_companySelectView.render().el)
		# 		
		# 		@input_opportunity_company_name = @$('.company_name input')
		# 		
		# 		@input_opportunity_company_name.attr('name', company_name_field_name)
		# 		@input_opportunity_company_name.attr('id', company_name_field_id)
		# 		
		# 		@opportunity_estimated_close_datepicker = @$(".opportunity_estimated_close .datepicker")
		# 			.datepicker
		# 				dateFormat: "yy-mm-dd"
		# 				altFormat: "yy-mm-dd"
		# 				altField: @$(".opportunity_estimated_close .altfield")
		# 				showAnim: ""
		# 		
		# 		@$(".opportunity_estimated_close .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")	
		# 		
		# 		@opportunity_estimated_close_datepicker_button.on(
		# 			"click"
		# 			() -> self.$(".opportunity_estimated_close .datepicker").datepicker("show")
		# 		)
		# 		
		# 		# self.$(".opportunity_estimated_close .datepicker").datepicker("show")
		# 		
		# 		@opportunity_actual_close_datepicker = @$(".opportunity_actual_close .datepicker")
		# 			.datepicker
		# 				altFormat: "yy-mm-dd"
		# 				dateFormat: "yy-mm-dd"
		# 				altField: @$(".opportunity_actual_close .altfield")
		# 				showAnim: ""
		# 		
		# 		@$(".opportunity_actual_close .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")
		# 	
		# 		@opportunity_actual_close_datepicker_button.on(
		# 			"click"
		# 			() -> self.$(".opportunity_actual_close .datepicker").datepicker("show")
		# 		)
		# 		
		# 		@opportunity_actual_cancel_datepicker = @$(".opportunity_actual_cancel .datepicker")
		# 			.datepicker
		# 				altFormat: "yy-mm-dd"
		# 				dateFormat: "yy-mm-dd"
		# 				altField: @$(".opportunity_actual_cancel .altfield")
		# 				showAnim: ""
		# 		
		# 		@$(".opportunity_actual_cancel .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")
		# 		
		# 		@opportunity_actual_cancel_datepicker_button.on(
		# 			"click"
		# 			() -> self.$(".opportunity_actual_cancel .datepicker").datepicker("show")
		# 		)
		# 		
		# 		@input_opportunity_estimated_value_interval.val(@model.get("estimated_value_interval"))
		# 		@input_opportunity_owner_key.val(@model.get("owner_key"))
		
		@vent.trigger("catalog_item:rendered")
		@
		
	setup: ->
		self = @
		# @opportunity_name = $('.opportunity_name')
		# 		@opportunity_company_name = $('.company_name')
		# 		@input_opportunity_name = $('.opportunity_name input')
		# 		@input_opportunity_company_name = $('.company_name input')
		# 		@input_opportunity_company_key = $('.company_key')
		# 		@input_opportunity_milestone_key = $('.opportunity_milestone_key input')
		# 		@input_opportunity_probability = $('.opportunity_probability input')
		# 		@input_opportunity_estimated_close = $('.opportunity_estimated_close input')
		# 		@input_opportunity_estimated_value = $('.opportunity_estimated_value input').first()
		# 		@input_opportunity_estimated_value_interval = $('.opportunity_estimated_close select')
		# 		@input_opportunity_owner_key = $('.opportunity_owner_key select')
		# 		@input_opportunity_actual_close = $('.opportunity_actual_close input')
		# 		@container_milestones = $('#milestones')
		# 		@container_users = $('#users')
		# 		
		# 		@opportunity_estimated_close_datepicker_button = $(".opportunity_estimated_close .icon-calendar")
		# 		@opportunity_actual_close_datepicker_button = $(".opportunity_actual_close .icon-calendar")
		# 		@opportunity_actual_cancel_datepicker_button = $(".opportunity_actual_cancel .icon-calendar")
		# 		
		# 		@_milestonesView.setElement(@container_milestones).render()
		# 		
		# 		@container_users.html(@_usersView.render().el)
		# 		
		# 		company_name_field_name = @input_opportunity_company_name.attr('name')
		# 		company_name_field_id = @input_opportunity_company_name.attr('id')
		# 		
		# 		@_companyComboView.setElement(@opportunity_company_name).render()
		# 		# @opportunity_company_name.html(@_companySelectView.render().el)
		# 		
		# 		@input_opportunity_company_name = $('.company_name input')
		# 		
		# 		@input_opportunity_company_name.attr('name', company_name_field_name)
		# 		@input_opportunity_company_name.attr('id', company_name_field_id)
		# 		
		# 		@opportunity_estimated_close_datepicker = $(".opportunity_estimated_close .datepicker")
		# 			.datepicker
		# 				dateFormat: "yy-mm-dd"
		# 				altFormat: "yy-mm-dd"
		# 				altField: $(".opportunity_estimated_close .altfield")
		# 				showAnim: ""
		# 		
		# 		$(".opportunity_estimated_close .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")
		# 		$(".opportunity_estimated_close .datepicker").on(
		# 			"blur"
		# 			() -> self.vent.trigger("estimated_close_date:blur")
		# 		)
		# 		# $(".opportunity_estimated_close .datepicker").on(
		# 		# 			"blur"
		# 		# 			self.vent.trigger("estimated_close_date:blur")
		# 		# 		)
		# 		
		# 		@opportunity_estimated_close_datepicker_button.on(
		# 			"click"
		# 			() -> $(".opportunity_estimated_close .datepicker").datepicker("show")
		# 		)
		# 		
		# 		# self.$(".opportunity_estimated_close .datepicker").datepicker("show")
		# 		
		# 		@opportunity_actual_close_datepicker = $(".opportunity_actual_close .datepicker")
		# 			.datepicker
		# 				altFormat: "yy-mm-dd"
		# 				dateFormat: "yy-mm-dd"
		# 				altField: $(".opportunity_actual_close .altfield")
		# 				showAnim: ""
		# 		
		# 		$(".opportunity_actual_close .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")
		# 		$(".opportunity_actual_close .datepicker").on(
		# 			"blur"
		# 			() -> self.vent.trigger("actual_close_date:blur")
		# 		)
		# 		
		# 		
		# 		@opportunity_actual_close_datepicker_button.on(
		# 			"click"
		# 			() -> $(".opportunity_actual_close .datepicker").datepicker("show")
		# 		)
		# 		
		# 		@opportunity_actual_cancel_datepicker = $(".opportunity_actual_cancel .datepicker")
		# 			.datepicker
		# 				altFormat: "yy-mm-dd"
		# 				dateFormat: "yy-mm-dd"
		# 				altField: $(".opportunity_actual_cancel .altfield")
		# 				showAnim: ""
		# 		
		# 		$(".opportunity_actual_cancel .datepicker").datepicker("option", "dateFormat", "mm/dd/yy")
		# 		$(".opportunity_actual_cancel .datepicker").on(
		# 			"blur"
		# 			() -> self.vent.trigger("actual_cancel_date:blur")
		# 		)
		# 		# $(".opportunity_actual_cancel .datepicker").on(
		# 		# 			"blur"
		# 		# 			self.vent.trigger("actual_cancel_date:blur")
		# 		# 		)
		# 		
		# 		@opportunity_actual_cancel_datepicker_button.on(
		# 			"click"
		# 			() -> $(".opportunity_actual_cancel .datepicker").datepicker("show")
		# 		)
		# 		
		# 		@input_opportunity_estimated_value_interval.val(@model.get("estimated_value_interval"))
		# 		@input_opportunity_owner_key.val(@model.get("owner_key"))
		
		@vent.trigger("catalog_item:rendered")
		
	
	rendered: ->
		# self = @
		# 		$(".opportunity_estimated_close .datepicker").on(
		# 			"blur"
		# 			() -> self.vent.trigger("estimated_close_date:blurred")
		# 		)
		# $('input[placeholder]').placeholder()
		# 		$('textarea[placeholder]').placeholder()
		
		
	opportunityNameChanged: ->
		# @model.set("name", @input_opportunity_name.val(), {silent: true})
		# 		@save()
	
	# checkEstimatedCloseDate: ->
	# 		if @opportunity_estimated_close_datepicker.val() == ""
	# 			$(".opportunity_estimated_close .altfield").val("")
	# 	
	# 	checkActualCloseDate: ->
	# 		if @opportunity_actual_close_datepicker.val() == ""
	# 			$(".opportunity_actual_close .altfield").attr("value", "")
	# 			
	# 	checkActualCancelDate: ->
	# 		if @opportunity_actual_cancel_datepicker.val() == ""
	# 			$(".opportunity_actual_cancel .altfield").val("")
		
	save: ->
		# self = @
		# 		modelid = @model.id
		# 		@model.set("contact_type_key", @_contactTypesView.getSelected().model.get("pub_key"), {silent: true})
		# 		if @model.isValid(true)
		# 			@model.save(
		# 				{
		# 					name: @model.get("name")
		# 					title: @model.get("title")
		# 					contact_type_key: @model.get("contact_type_key")
		# 					company_key: @model.get("company_key")
		# 				},
		# 				{
		# 					error: @handleError
		# 					success: (model) -> 
		# 						if modelid != model.id
		# 							enablePushState = true  
		# 							pushState = !!(enablePushState and window.history and window.history.pushState)
		# 							if pushState
		# 								Backbone.history.navigate("contacts/" + model.get("pub_key") + "/edit", {trigger: false, replace: true})
		# 								_.each(self._contactPhonesView._phoneViews, (v) -> if v.shouldSave() then v.save())
		# 							else
		# 								_.each(self._contactPhonesView._phoneViews, (v) -> if v.shouldSave() then v.save())
		# 								window.location.replace(model.get("pub_key") + "/edit")
		# 					silent: true
		# 				}
		# 			)
	
	handleSaveErrors: (model, response) ->
		# if response.status == 422
		# 			errors = $.parseJSON(response.responseText).errors
		# 			for atttribute, messages of errors
		# 				self.handleError(attribute, message)
	
	handleError: (attribute, message) ->
		# @$el.find(".control-group.#{attribute}").addClass('error').find('.controls').append("<span class=\"help-inline\">#{message}</span>")
	
	clearError: (attribute) ->
		# @$el.find(".control-group.#{attribute}").removeClass('error').find('.help-inline').remove()
				
	# milestoneChanged: (evt) ->
	# 		self = @
	# 		milestone = evt.milestone
	# 		if milestone
	# 			@model.set("probability", milestone.get("probability"), {silent: true})
	# 			@input_opportunity_probability.attr('value', (milestone.get("probability") * 100))
	# 	
	# 	companyNameChanged: (evt) ->
	# 		self = @
	# 		company = _.find(self.companies.models, (m) -> m.get("name") == evt.company_name)
	# 		if company
	# 			@model.set("company_key", company.get("pub_key"), {silent: true})
	# 			@input_opportunity_company_key.val(company.get("pub_key"))
	# 			# @save()
	# 		else
	# 			@model.unset("company_key", {silent: true})
	# 			@input_opportunity_company_key.val('')
	# 			# if evt.company_name != ''
	# 			# 				company = new Quota.Models.Contact()
	# 			# 				company.save(
	# 			# 					{
	# 			# 						name: evt.company_name
	# 			# 						contact_type_key: _.first(self.contact_types.where({name: "Company"})).get("pub_key")
	# 			# 					},{
	# 			# 						error: (model, response) ->
	# 			# 							self.handleError(model, response)
	# 			# 						success: (model) ->
	# 			# 							self.companies.add(model)
	# 			# 							self._companySelectView.remove()
	# 			# 							self.model.set("company_key", model.get("pub_key"), {silent: true})
	# 			# 							self._companySelectView = new Quota.Views.CompanySelectView({parent_model:self.model, collection:self.companies, source: "name", val: "pub_key", className: 'string input-xlarge', vent: self.vent})
	# 			# 							self.contact_company_name.html(self._companySelectView.render().el)
	# 			# 							self.save()
	# 			# 					}
	# 			# 				)
	# 			# 			else
	# 			# 				@save()

		
	setMilestoneRelatedFields: ->
		# self = @
		# 		ct = _.find self.contact_types.models, (cm) -> cm.get("pub_key") == self.model.get("contact_type_key")
		# 		if ct and ct.get("name") == "Company"
		# 			@contact_title.hide()
		# 			@contact_company_name.hide()
		# 			@input_contact_name.attr('placeholder', 'Company Name')
		# 		else
		# 			@contact_title.show()
		# 			@contact_company_name.show()
		# 			@input_contact_name.attr('placeholder', 'First Last')
