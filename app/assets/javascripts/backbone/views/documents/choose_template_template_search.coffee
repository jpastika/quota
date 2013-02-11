class Quota.Views.ChooseTemplateTemplateSearch extends Backbone.View

	# template: HandlebarsTemplates['documents/choose_template_template_search'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	# events:
		
			
	initialize: (options)->
		self = @
		_.bindAll(@)
		@vent = options.vent
		
		@_templateComboView = new Quota.Views.TemplateComboView({source: "name", val: "name", className: 'string required', vent: @vent})
		@_templateComboView.on("template_combo:item_selected", @templateSelected)
		

	render: ->
		# $(@el).html(@template())
		
		@input_template_search = @$('.template_search')
		
		@_templateComboView.el = @input_template_search
		@_templateComboView.render()
		
		@
		
	hideSpinner: () ->
		@spinner.hide()

	showSpinner: () ->
		@spinner.show()

	toggleSpinner: () ->
		@spinner.toggle()

	templateSelected: (obj)->
		# @vent.trigger('template_search:choose_template',{template: obj.template})
		
		# console.log obj
		# @catalog_item = new Quota.Models.CatalogItem(obj.catalog_item)
		# 		if obj.catalog_item.pub_key
		# 			@setCatalogItem(@catalog_item)
		# 			@input_template_item_name.val(obj.catalog_item.name)
		# 			# @name_holder.html(obj.catalog_item.name)
		# 			@input_template_item_part_number.val(obj.catalog_item.part_number)
		# 			# @part_number_holder.html(obj.catalog_item.part_number)
		# 			@input_template_item_unit_price.val(obj.catalog_item.list_price)
		# 			@input_template_item_unit_price_unit.val(obj.catalog_item.recurring_unit)
		# 			@updateTotal()
		# 			@input_template_item_total_unit.val(obj.catalog_item.recurring_unit)
		# 			# @total_unit_holder.html(obj.catalog_item.recurring_unit)
		# 			@input_template_item_description.val(obj.catalog_item.description)
		# 			# @description_holder.html(obj.catalog_item.description)
		# 			@input_template_item_catalog_item_key.val(obj.catalog_item.pub_key)
		# 		else
		# 			@setCatalogItem(null)
		# 			@input_template_item_name.val(obj.catalog_item.name)
		# 			# @name_holder.html('')
		# 			@input_template_item_part_number.val('')
		# 			# @part_number_holder.html('')
		# 			@input_template_item_unit_price.val(0)
		# 			@input_template_item_unit_price_unit.val('')
		# 			@input_template_item_total.val(@calcTotal())
		# 			@input_template_item_total_unit.val('')
		# 			# @total_unit_holder.html('')
		# 			@input_template_item_description.val('')
		# 			# @description_holder.html('')
		# 			@input_template_item_catalog_item_key.val('')
		# 			
		# 		@handleItemType()