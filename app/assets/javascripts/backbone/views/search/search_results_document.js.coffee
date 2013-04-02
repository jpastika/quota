class Quota.Views.SearchResultsDocument extends Quota.Views.SearchResultsItem

	template: HandlebarsTemplates['search/search_results_document'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	handleClick: (evt) ->
		self = @
		window.location.href="/documents/#{self.model.get("pub_key")}"