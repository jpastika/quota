class QuotesController < ApplicationController
  
  def new
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    @document = @opportunity.documents.build(account_key: current_member.account.pub_key, creator_key: current_member.pub_key, document_type: "Quote")
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
  
end
