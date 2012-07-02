class Quota.Models.Contact extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contacts'
	
	
	initialize: ->
	    this.phones = new Quota.Collections.ContactPhones
	    this.phones.url = '/api/contacts/' + this.id + '/phones'
	    # this.phones.on("reset", this.updateCounts)