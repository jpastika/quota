class Quota.Views.SearchFormBlock extends Backbone.View

	events: ->
		#standard events first
		_events = {}
		_events["click " + @.options.toggle] = "moreOptionsClicked"
		_events["click " + @.options.searchbutton] = "searchClicked"
		_events
  	
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@primary = $(@el).find(options.primary).first()
		@secondary = $(@el).find(options.secondary).first()
		@toggle = $(@el).find(options.toggle).first()
		
	render: ->
		@
		
	moreOptionsClicked: ->
		@secondary.toggle()
		@handleToggle()
	
	handleToggle: ->
		if @toggle.find('i').first().hasClass('icon-circle-arrow-down')
			@toggle.html('<i class="icon-circle-arrow-up"></i>hide options')
		else
			@toggle.html('<i class="icon-circle-arrow-down"></i>more options')
				
	searchClicked: ->
		@vent.trigger('search:clicked')
