class Quota.Views.SearchResultsOpportunity extends Quota.Views.SearchResultsItem

	template: HandlebarsTemplates['search/search_results_opportunity'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	handleClick: (evt) ->
		self = @
		window.location.href="/opportunities/#{self.model.get("pub_key")}"