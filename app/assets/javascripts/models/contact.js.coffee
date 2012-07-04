class Quota.Models.Contact extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contacts'
	
	defaults: {
	}
	
	validate: (attrs) ->
		if @get("name") and !@get("name").trim().length then "Name can't be left blank"
	
	initialize: ->
	    @phones = new Quota.Collections.ContactPhones
	    @phones.url = '/api/contacts/' + @id + '/phones'
	    # this.phones.on("reset", this.updateCounts)