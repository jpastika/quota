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

Handlebars.registerHelper('equal', function(lvalue, rvalue, options) {
    if (arguments.length < 3)
        throw new Error("Handlebars Helper equal needs 2 parameters");
    if( lvalue!=rvalue ) {
        return options.inverse(this);
    } else {
        return options.fn(this);
    }
});

// format an ISO date using Moment.js
// http://momentjs.com/
// moment syntax example: moment(Date("2011-07-18T15:50:52")).format("MMMM YYYY")
// usage: {{dateFormat creation_date format="MMMM YYYY"}}
// Handlebars.registerHelper('dateFormat', function(context, block) {
// 	if (window.moment) {
// 		var f = block.hash.format || "MMM Do, YYYY";
// 		return moment(Date(context)).format(f);
// 	}else{
// 		return context; // moment plugin not available. return data as is.
// 	}
// });
Handlebars.registerHelper('dateFormat', function(context, block) {
	if (window.moment && context && moment(context).isValid()) {
		var f = block.hash.format || "MMM Do, YYYY";
		return moment(context).format(f);
	}else{
		return context;   //  moment plugin is not available, context does not have a truthy value, or context is not a valid date
	}
});