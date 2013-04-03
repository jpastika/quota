class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  around_filter :scope_current_user
  around_filter :scope_current_account
  
  def search
    @search = params[:search]
    
    respond_to do |format|
      format.html {
        @documents_by_name = Document.search_name(@search)
        @documents_by_opportunity_name = Document.search_opportunity_name(@search)
        @documents_by_opportunity_company_name = Document.search_opportunity_company_name(@search)
        @documents_by_po = Document.search_po(@search)
        @documents_by_part_number = Document.search_part_number(@search)
        @documents_by_part_name = Document.search_part_name(@search)
        @opportunities_by_name = Opportunity.search_name(@search)
        @opportunities_by_company = Opportunity.search_company(@search)
        @templates_by_name = Template.search_name(@search)
        @templates_by_part_name = Template.search_part_name(@search)
        @templates_by_part_number = Template.search_part_number(@search)
        @contacts_by_name = Contact.search_name(@search)
        @contacts_by_company = Contact.search_company(@search)
        @catalog_items_by_name = CatalogItem.search_name(@search)
        @catalog_items_by_part_number = CatalogItem.search_part_number(@search)

        gon.documents_by_name = @documents_by_name.to_json(:include => [])
        gon.documents_by_opportunity_name = @documents_by_opportunity_name.to_json(:include => [])
        gon.documents_by_opportunity_company_name = @documents_by_opportunity_company_name.to_json(:include => [])
        gon.documents_by_po = @documents_by_po.to_json(:include => [])
        gon.documents_by_part_number = @documents_by_part_number.to_json(:include => [])
        gon.documents_by_part_name = @documents_by_part_name.to_json(:include => [])
        gon.opportunities_by_name = @opportunities_by_name.to_json(:include => [:milestone, :owner, :company])
        gon.opportunities_by_company = @opportunities_by_company.to_json(:include => [:milestone, :owner, :company])
        gon.templates_by_name = @templates_by_name.to_json(:include => [])
        gon.templates_by_part_name = @templates_by_part_name.to_json(:include => [])
        gon.templates_by_part_number = @templates_by_part_number.to_json(:include => [])
        gon.contacts_by_name = @contacts_by_name.to_json(:include => [])
        gon.contacts_by_company = @contacts_by_company.to_json(:include => [])
        gon.catalog_items_by_name = @catalog_items_by_name.to_json(:include => [])
        gon.catalog_items_by_part_number = @catalog_items_by_part_number.to_json(:include => [])
      }
      format.json { 
      
      }
    end
  end
  
private
  
  def scope_current_account
    Account.current_account_key = current_user ? current_user.account.pub_key : nil
    yield
  ensure
    Account.current_account_key = nil
  end
  
  def scope_current_user
    User.current_user_key = current_user ? current_user.pub_key : nil
    yield
  ensure
    User.current_user_key = nil
  end
end
