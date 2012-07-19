class Quota.Models.Opportunity extends Backbone.Model
	idAttribute: 'pub_key'
	urlRoot: '/api/opportunities'
	
	defaults: {
	}
	
	validation:
		name:
			required: true
			msg: "can't be blank"
	
	initialize: ->
		# @phones = new Quota.Collections.ContactPhones
		# 		@phones.url = '/api/contacts/' + @id + '/phones'
		# 		@emails = new Quota.Collections.ContactEmails
		# 		@emails.url = '/api/contacts/' + @id + '/emails'
		# 		@urls = new Quota.Collections.ContactUrls
		# 		@urls.url = '/api/contacts/' + @id + '/urls'
		# 		@addresses = new Quota.Collections.ContactAddresses
		# 		@addresses.url = '/api/contacts/' + @id + '/addresses'
	    # this.phones.on("reset", this.updateCounts)