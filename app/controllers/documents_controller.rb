class DocumentsController < ApplicationController
  before_filter :signed_in_member!, :check_disabled!
  
  # def index
  #     @documents = current_member.account.documents
  #     @my_created_documents = current_member.created_documents
  #     @my_opportunity_documents = current_member.owned_opportunity_documents
  #   end
  #   
  # def new
  #     @opportunity = Opportunity.find_by_pub_key(params[:id])
  #     @document = @opportunity.documents.build(account_key: current_member.account.pub_key, creator_key: current_member.pub_key, document_type: params[:document_type])
  #     
  #     @document.name = "#{params[:document_type]} - #{@opportunity.name}"
  #     
  #     if @document.save
  #       redirect_to edit_document_path(@document.pub_key)
  #     else
  #       flash[:error] = "Unable to create #{params[:document_type]}"
  #       redirect_to opportunity_path(@opportunity.pub_key)
  #     end
  #   end
  #   
  #   def create
  #     @document = Document.new(params[:document])
  #     @document.account = current_member.account
  #     @document.created_by = current_member
  #     if @document.save
  #       flash[:success] = "#{@document.document_type} created!"
  #       redirect_to opportunity_path(@document.opportunity.pub_key)
  #     else
  #       render 'new'
  #     end
  #   end
  #   
  #   
  #   def destroy
  #     @document = Document.find_by_pub_key(params[:id])
  #     @document.destroy
  #     redirect_back_or documents_path
  #   end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def new
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    if params.has_key?(:template_key)
      @template = current_member.account.templates.find_by_pub_key(params[:template_key])
    else
      @template = current_member.account.templates.find_by_document_type_key(params[:document_type], :conditions => {:is_document_type_default => true})
    end
    
    @document_type = @template.document_type
    @document = @opportunity.documents.build(account: current_member.account, creator_key: current_member.pub_key, document_type: @document_type)
    
    @document.name = "#{@document_type.name} - #{@opportunity.name}"
    
    #get document items from temoplate
    
    @template.template_items.each do |item|
      doc_item = @document.document_items.build(
        name: item.name, 
        document_item_type: item.document_item_type
      )
      doc_item.save
    end 
    
    if @document.save
      redirect_to edit_document_path(@document.pub_key)
    else
      flash[:error] = "Unable to create #{@@document_type.name}"
      redirect_to opportunity_path(@opportunity.pub_key)
    end
  end
  
  def create
    @document = Document.new(params[:quote])
    @document.account = current_member.account
    @document.created_by = current_member
    if @document.save
      flash[:success] = "#{@document.document_type.name} created!"
      redirect_to opportunity_path(@document.opportunity.pub_key)
    else
      render 'new'
    end
  end
  
  def index
    respond_to do |format|
      format.html {
        @documents = current_member.account.documents
        @my_created_documents = current_member.created_documents
        @my_opportunity_documents = current_member.owned_opportunity_documents
      }
      format.json { 
        if params[:id]
          @opportunity = Opportunity.find_by_pub_key(params[:id])
          render :json => @opportunity.documents
        else  
          render :json => Document.all
        end
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        @document = Document.find_by_pub_key(params[:id])
      }
      format.json {
        @document = Document.find_by_pub_key(params[:id]) 
        render :json => @document.to_json(:include => :opportunity, :include => :document_type)
      }
    end
  end
  
  def edit
    @document = Document.find_by_pub_key(params[:id])
  end
  
  def update
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @document = Document.find_by_pub_key(params[:id])
        render :json => @document.update_attributes(params[:quote])
      }
    end
  end
  
  def destroy
    @document = Document.find_by_pub_key(params[:id])
    @document.destroy
    redirect_back_or opportunity_path(id: @document.opportunity.pub_key)
  end
end
