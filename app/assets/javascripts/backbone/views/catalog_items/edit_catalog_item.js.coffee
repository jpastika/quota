class Quota.Views.EditCatalogItem extends Backbone.View

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
		@el = options.el
		@vent = options.vent
		@manufacturers = options.manufacturers
		@_manufacturerComboView = new Quota.Views.ManufacturerComboView({parent_model:@model, collection:@manufacturers, el: '#catalog_item_manufacturer', source: "manufacturer", val: "manufacturer", className: 'string input-xlarge', vent: @vent})
		@model.on('change', @render, @)
		@vent.on('manufacturer_name:changed', @manufacturerNameChanged, @)
		@vent.on('catalog_item:rendered', @rendered, @)
		
	render: ->
		self = @
		@catalog_item_name = @$('.catalog_item_name')
		@manufacturer_name = @$('#catalog_item_manufacturer')
		@input_manufacturer_name = @$('#catalog_item_manufacturer')
		manufacturer_name_field_name = @input_manufacturer_name.attr('name')
		manufacturer_name_field_id = @input_manufacturer_name.attr('id')
		
		@_manufacturerComboView.render()
		
		@input_manufacturer_name = @$('#catalog_item_manufacturer')
		
		@input_manufacturer_name.attr('name', manufacturer_name_field_name)
		@input_manufacturer_name.attr('id', manufacturer_name_field_id)
		
		@vent.trigger("catalog_item:rendered")
		@
		
	setup: ->
		self = @
		@catalog_item_name = @$('.catalog_item_name')
		@manufacturer_name = $('#catalog_item_manufacturer')
		@input_manufacturer_name = $('#catalog_item_manufacturer')
		@input_manufacturer_key = $('.manufacturer_key')
		manufacturer_name_field_name = @input_manufacturer_name.attr('name')
		manufacturer_name_field_id = @input_manufacturer_name.attr('id')
		
		@_manufacturerComboView.render()
		
		@input_manufacturer_name = $('#catalog_item_manufacturer')
		
		@input_manufacturer_name.attr('name', manufacturer_name_field_name)
		@input_manufacturer_name.attr('id', manufacturer_name_field_id)
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
	manufacturerNameChanged: (evt) ->
		console.log "changed"
		self = @
		manufacturer = _.find(self.manufacturers.models, (m) -> m.get("name") == evt.manufacturer_name)
		if manufacturer
			# @model.set("company_key", company.get("pub_key"), {silent: true})
			# 			@input_opportunity_company_key.val(company.get("pub_key"))
	# 			# @save()
		else
			# @model.unset("company_key", {silent: true})
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
