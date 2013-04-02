class Quota.Views.SearchResultsCatalogItem extends Quota.Views.SearchResultsItem

	template: HandlebarsTemplates['search/search_results_catalog_item'] #Handlebars.compile($("#quote-template").html()) #JST['quotes/index']
	
	handleClick: (evt) ->
		self = @
		window.location.href="/catalog_items/#{self.model.get("pub_key")}"