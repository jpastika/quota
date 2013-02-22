class Quota.Views.IndexContactEmails extends Backbone.View

	
	# template: HandlebarsTemplates['opportunities/show_opp_contacts'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	# el: '#contact_emails_container'
	el: '.contact_emails'
	
	events:
		"click #contact-emails-actions>.btn-primary": "addClicked"
		"click #contact-emails-actions>.btn-danger": "doneClicked"
		
	initialize: (options)->
		_.bindAll(@)
		@vent = options.vent
		@contact = options.parent_model
		@parent_child_key = options.parent_child_key
		
		@_addEmailView = new Quota.Views.EditContactFormAddEmail({model: new Quota.Models.ContactEmail(), parent_model:@contact, parent_child_key: @contact.get("pub_key"), vent: @vent, parent_collection: @collection})
		
		@_emailsListView = new Quota.Views.IndexContactEmailsList({model: new Quota.Models.ContactEmail(), parent_model:@contact, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		# @_contactsListView = new Quota.Views.ShowOpportunityContactsList({model: new Quota.Models.Contact(), parent_model:@opportunity, parent_child_key: @parent_child_key, vent: @vent, collection: @collection})
		
		@vent.on('contact_emails:add_new_email_successful', @addNewEmail_Success, @)
		@vent.on('contact_emails:remove_email', @removeContactEmail, @)
		
		
	render: ->
		# @container_email_list = @$('.section-table tbody')
		@container_email_list = @$('.contact_emails_list')
		@_emailsListView.setElement(@container_email_list).render()
		@container_add_email = @$('.section-form')
		@_addEmailView.setElement(@container_add_email).render()
		@
	
	addClicked: ->
		@vent.trigger('add_email:clicked')
		@_addEmailView.resetAddNewEmailForm()
		@hideAddBtn()
		@showDoneLink()
		@showAddForm()
		

	doneClicked: ->
		@vent.trigger('done_add_email:clicked')
		@_addEmailView.resetAddNewEmailForm()
		@hideDoneLink()
		@showAddBtn()
		@hideAddForm()
		
	removeContactEmail: (item)->
		@collection.remove(item)
		
	addNewEmail_Success: ()->
		@doneClicked()

	hideAddBtn: ->
		@$('#contact-emails-actions>.btn-primary').toggle(false)

	showAddBtn: ->
		@$('#contact-emails-actions>.btn-primary').toggle(true)

	hideDoneLink: ->
		@$('#contact-emails-actions>.btn-danger').toggle(false)

	showDoneLink: ->
		@$('#contact-emails-actions>.btn-danger').toggle(true)
	
	hideAddForm: ->
		@$('.section-form').toggle(false)

	showAddForm: ->
		@$('.section-form').toggle(true)
