class Quota.Views.SearchResultsContact extends Quota.Views.SearchResultsItem

	template: HandlebarsTemplates['search/search_results_contact'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	handleClick: (evt) ->
		self = @
		window.location.href="/contacts/#{self.model.get("pub_key")}"