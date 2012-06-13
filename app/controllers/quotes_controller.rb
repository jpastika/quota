class QuotesController < ApplicationController
  
  def new
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    @quote = @opportunity.quotes.build(account_key: current_member.account.pub_key, creator_key: current_member.pub_key)
    
    @quote.name = "Quote - #{@opportunity.name}"
    
    if @quote.save
      redirect_to edit_quote_path(@quote.pub_key)
    else
      flash[:error] = "Unable to create quote"
      redirect_to opportunity_path(@opportunity.pub_key)
    end
  end
  
  def create
    @quote = Quote.new(params[:quote])
    @quote.account = current_member.account
    @quote.created_by = current_member
    if @quote.save
      flash[:success] = "Quote created!"
      redirect_to opportunity_path(@quote.opportunity.pub_key)
    else
      render 'new'
    end
  end
  
  def show
    @quote = Quote.find_by_pub_key(params[:id])
  end
  
  def edit
    @quote = Quote.find_by_pub_key(params[:id])
  end
  
end
