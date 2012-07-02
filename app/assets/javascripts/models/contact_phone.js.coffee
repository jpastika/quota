class Quota.Models.ContactPhone extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/contact_phones'
	
	initialize: ->
	    this.name = 'phone'
	    this.val = '123-123-1234'
