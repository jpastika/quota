Handlebars.registerHelper("ifIsContactTypeSelected", function(contact, contact_type, options) {
	if((contact.contact_type_key == contact_type.pub_key) || (!contact.contact_type_key && contact_type.name == "Person") ) {
		return options.fn(this);
	} else {
		return options.inverse(this);
	}
});