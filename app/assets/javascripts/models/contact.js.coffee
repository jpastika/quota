class Quota.Models.Contact extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contacts'
	
	defaults: {
	}
	
	validation:
		name:
			required: true
			msg: "can't be blank"
	
	initialize: ->
		@phones = new Quota.Collections.ContactPhones
		@phones.url = '/api/contacts/' + @id + '/phones'
	    # this.phones.on("reset", this.updateCounts)