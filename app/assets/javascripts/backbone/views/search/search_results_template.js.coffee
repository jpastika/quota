class Quota.Views.SearchResultsTemplate extends Quota.Views.SearchResultsItem

	template: HandlebarsTemplates['search/search_results_template'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	handleClick: (evt) ->
		self = @
		window.location.href="/templates/#{self.model.get("pub_key")}"