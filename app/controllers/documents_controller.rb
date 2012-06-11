class DocumentsController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  def index
    @documents = current_member.account.documents
    @my_created_documents = current_member.created_documents
    @my_opportunity_documents = current_member.owned_opportunity_documents
  end
  
  def new
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    @document = @opportunity.documents.build(account_key: current_member.account.pub_key, creator_key: current_member.pub_key)
  end
  
  def create
    @document = Document.new(params[:document])
    @document.account = current_member.account
    @document.created_by = current_member
    if @document.save
      flash[:success] = "Document created!"
      redirect_to opportunity_path(@document.opportunity.pub_key)
    else
      render 'new'
    end
  end
  
  
  def destroy
    @document = Document.find_by_pub_key(params[:id])
    @document.destroy
    redirect_back_or documents_path
  end
end
