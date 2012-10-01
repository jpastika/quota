Quota.Validate = (model, changedAttributes) ->
	(->
		@errors = {}
		@attributes = _.clone(model.attributes)
		_.extend @attributes, changedAttributes
		_.each model.validates, (value, rule) ->
			@validators[rule] value

		@validators = {
			required: (fields) ->
				_.each fields, (field) ->
					@addError field, "errors.form.required"  if _.isEmpty(this.attributes[field]) is true
		}

		@addError = (field, message) ->
			@errors[field] = []  if _.isUndefined(@errors[field])
			@errors[field].push message
		
		@errors
	)()