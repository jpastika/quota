Handlebars.registerHelper("ifIsContactTypeSelected", function(contact, contact_type, options) {
	if((contact.contact_type_key == contact_type.pub_key) || (!contact.contact_type_key && contact_type.name == "Person") ) {
		return options.fn(this);
	} else {
		return options.inverse(this);
	}
});


Handlebars.registerHelper('list', function(items, options) {
  var out = "<ul>";

  for(var i=0, l=items.length; i<l; i++) {
    out = out + "<li>" + options.fn(items[i]) + "</li>";
  }

  return out + "</ul>";
});

Handlebars.registerHelper('each', function(context, options) {
  var ret = "";

  for(var i=0, j=context.length; i<j; i++) {
    ret = ret + options.fn(context[i]);
  }

  return ret;
});