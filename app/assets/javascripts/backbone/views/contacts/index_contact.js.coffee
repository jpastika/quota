class Quota.Views.IndexContact extends Backbone.View
	
	template: HandlebarsTemplates['contacts/index_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']

	el: '#contact'

	events:
		"click .contact_btn_edit": "handleEdit"
		"click .contact_btn_done": "handleDone"
		"click .contact_edit_is_company input": "handleIsCompanyClick"
		"blur  .contact_edit_name input": "saveModel"
		"blur  .contact_edit_title input": "saveModel"
		# "click .add_contact": "handleAddContactClick"
		
	initialize: (options)->
		self = @
		_.bindAll(@)
		
		@vent = options.vent
		
		@phones = new Quota.Collections.ContactPhones(@model.get("phones"))
		@emails = new Quota.Collections.ContactEmails(@model.get("emails"))
		@urls = new Quota.Collections.ContactUrls(@model.get("urls"))
		@addresses = new Quota.Collections.ContactAddresses(@model.get("addresses"))
		
		@_phonesView = new Quota.Views.IndexContactPhones({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@phones, vent: @vent})
		@_emailsView = new Quota.Views.IndexContactEmails({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@emails, vent: @vent})
		@_urlsView = new Quota.Views.IndexContactUrls({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@urls, vent: @vent})
		@_addressesView = new Quota.Views.IndexContactAddresses({parent_model:@model, parent_child_key: @model.get("pub_key"), collection:@addresses, vent: @vent})
		
		# @_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, collection:@companies, source: "name", val: "pub_key", className: '', vent: @vent})
		@_companyComboView = new Quota.Views.CompanyComboView({parent_model:@model, source: "name", val: "pub_key", className: '', vent: @vent})
		
		@_companyComboView.on("company_combo:item_selected", @companySelected)
		
	render: ->
		$(@el).empty()
		$(@el).html(@template({contact:@model.toJSON()}))
		
		@contact_show = @$('.contact_show')
		@contact_edit = @$('.contact_edit')
		
		@contact_btn_edit = @$('.contact_btn_edit')
		@contact_btn_done = @$('.contact_btn_done')
		
		@container_phones = @$('.contact_phones')
		@container_emails = @$('.contact_emails')
		@container_urls = @$('.contact_urls')
		@container_addresses = @$('.contact_addresses')
		
		@container_icon = @$('.contact_icon')
		@container_name = @$('.contact_edit_name')
		@container_title = @$('.contact_edit_title')
		@container_company = @$('.contact_edit_company')
		@container_is_company = @$('.contact_edit_is_company')
		
		@icon = @$('.contact_icon i')
		@input_name = @$('.contact_edit_name input')
		@input_title = @$('.contact_edit_title input')
		@input_company = @$('.contact_edit_company input')
		@input_is_company = @$('.contact_edit_is_company input')
		@input_company_key = @$('.contact_company_key')
		@input_pub_key = @$('.contact_pub_key')
		
		@_phonesView.setElement(@container_phones).render()
		@_emailsView.setElement(@container_emails).render()
		@_urlsView.setElement(@container_urls).render()
		@_addressesView.setElement(@container_addresses).render()
		
		@spinner = @$('.icon-spinner')
		
		# company_name_field_name = @input_company.attr('name')
		# 		company_name_field_id = @input_company.attr('id')
		# 		
		# 		@_companyComboView.setElement(@container_company).render()
		# 		
		# 		@input_company = $('.contact_edit_company input')
		# 		
		# 		@input_company.attr('name', company_name_field_name)
		# 		@input_company.attr('id', company_name_field_id)
		
		@_companyComboView.el = @input_company
		@_companyComboView.render()
		
		
		@
		
	companySelected: (obj)->
		if obj.company.pub_key
			@input_company_key.val(obj.company.pub_key)
		else
			@input_company_key.val(null)
		
		# 			@setCatalogItem(@catalog_item)
		# 			@input_template_item_name.val(obj.catalog_item.name)
		# 			@name_holder.html(obj.catalog_item.name)
		# 			@input_template_item_part_number.val(obj.catalog_item.part_number)
		# 			@part_number_holder.html(obj.catalog_item.part_number)
		# 			@input_template_item_unit_price.val(obj.catalog_item.list_price)
		# 			@unit_price_holder.html(obj.catalog_item.list_price)
		# 			@input_template_item_unit_price_unit.html(obj.catalog_item.recurring_unit)
		# 			@unit_price_unit_holder.html(obj.catalog_item.recurring_unit)
		# 			@updateTotal()
		# 			@input_template_item_total_unit.html(obj.catalog_item.recurring_unit)
		# 			@total_unit_holder.html(obj.catalog_item.recurring_unit)
		# 			@input_template_item_description.val(obj.catalog_item.description)
		# 			@description_holder.html(obj.catalog_item.description)
		# 			@input_template_item_catalog_item_key.val(obj.catalog_item.pub_key)
		# 		else
		# 			@setCatalogItem(null)
		# 			@input_template_item_name.val(obj.catalog_item.name)
		# 			@name_holder.html(obj.catalog_item.name)
		# 			@input_template_item_part_number.val('')
		# 			@part_number_holder.html('')
		# 			@input_template_item_unit_price.val(0)
		# 			@unit_price_holder.html('')
		# 			@input_template_item_unit_price_unit.val('')
		# 			@unit_price_unit_holder.html('')
		# 			@updateTotal()
		# 			@input_template_item_total_unit.val('')
		# 			@total_unit_holder.html('')
		# 			@input_template_item_description.val('')
		# 			@description_holder.html('')
		# 			@input_template_item_catalog_item_key.val('')
		# 
		# 		@decorateShow()
		# 		@handleItemType()
		@saveModel()
		
	decorateShow: ->
	
	setHolders: ->	
		
	handleEdit: ->
		@vent.trigger('contact:edit')
		@toggleEdit()
		
	handleDone: ->
		@vent.trigger('contact:done')
		# @saveModel()
		@toggleShow()
	
	toggleEdit: ->
		@contact_show.hide()
		@contact_edit.show()
		@contact_btn_edit.hide()
		@contact_btn_done.show()
		
	toggleShow: ->
		@contact_edit.hide()
		@contact_show.show()
		@contact_btn_done.hide()
		@contact_btn_edit.show()
		
	showSpinner: ->
		@spinner.show()
		
	hideSpinner: ->
		@spinner.hide()

	handleIsCompanyClick: ->
		if @input_is_company.is(':checked')
			@container_title.hide()
			@container_company.hide()
			@icon.removeClass('icon-user').addClass('icon-building')
			@input_company_key.val(null)
			@input_company.val(null)
		else
			@container_title.show()
			@container_company.show()
			@icon.removeClass('icon-building').addClass('icon-user')
			
	saveModel: ->
		self = @
		@showSpinner()
		@model.save(
			{
				name: @input_name.val()
				title: @input_title.val()
				company_name: @input_company.val()
				company_key: @input_company_key.val()
				is_company: @input_is_company.is(':checked')
			},
			{
				error: ->
					self.hideSpinner()
					# console.log "save error"
				success: (model) -> 
					if model.get("company")
						self.input_company_key.val(model.get("company").pub_key)
					else
						self.input_company_key.val(null)
					# self.vent.trigger('template_items:add_new_template_item_successful', {model: model})
					self.setHolders()
					self.decorateShow()
					self.hideSpinner()
			}
		)