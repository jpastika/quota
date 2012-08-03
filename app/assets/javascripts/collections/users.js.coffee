class Quota.Collections.Users extends Backbone.Collection

	model: Quota.Models.User
	url: '/api/users'
	comparator: (m) ->
		return m.get("name")
