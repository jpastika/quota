class Quota.Collections.Milestones extends Backbone.Collection

	model: Quota.Models.Milestone
	url: '/api/milestones'
	
	comparator: (m) ->
		return m.get("name")
