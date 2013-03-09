class DocumentsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def new
    @opportunity = Opportunity.find_by_pub_key(params[:id])
    
    # if params.has_key?(:template_key)
    #       @template = Templates.find_by_pub_key(params[:template_key])
    #     else
    #       @template = Templates.find_by_document_type_key(params[:document_type], :conditions => {:is_document_type_default => true})
    #     end
    #     
    @document_type = DocumentType.find_by_name("Quote")
    @document = @opportunity.documents.build(creator_key: current_user.pub_key, document_type: @document_type, company: @opportunity.company)
    
    
    @companies = Contact.companies
    @contacts = Contact.people
    
    gon.companies = @companies.to_json(:include => [:addresses, :phones, :emails])
    gon.contacts = @contacts.to_json(:include => [:addresses, :phones, :emails])
    
    gon.document = @document
    
    
    # @document = @opportunity.documents.build(creator_key: current_user.pub_key)
    #     
    #     @document.name = "#{@opportunity.documents.length+1} - #{@opportunity.name}"
    
    #get document items from temoplate
    
    # @template.template_items.each do |item|
    #       doc_item = @document.document_items.build(
    #         name: item.name, 
    #         document_item_type: item.document_item_type
    #       )
    #       doc_item.save
    #     end 
    
    # if @document.save
    #       redirect_to :action => "choose_template", :id => @document.pub_key
    #     else
    #       flash[:error] = "Unable to create document"
    #       redirect_to opportunity_path(@opportunity.pub_key)
    #     end
  end
  
  def create
    @document = Document.create(params[:document])
    # @document.account = current_user.account
    @document.created_by = current_user
    
    
    if @document.save
      # flash[:success] = "#{@document.document_type.name} created!"
      redirect_to :action => "choose_template", :id => @document.pub_key
    else
      render 'new'
    end
  end
  
  def index
    respond_to do |format|
      format.html {
        @documents = Document.all
        @my_created_documents = current_user.created_documents
        @my_opportunity_documents = current_user.owned_opportunity_documents
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
        @opportunity = Opportunity.find_by_pub_key(@document.opportunity_key)
        
        gon.document = @document.to_json()
        gon.document_items = @document.document_items.to_json(:include => [:catalog_item])
        gon.opportuity = @opportunity.to_json()
      }
      format.json {
        @document = Document.find_by_pub_key(params[:id]) 
        render :json => @document.to_json(:include => :opportunity, :include => :document_type)
      }
    end
  end
  
  def edit
    @document = Document.find_by_pub_key(params[:id])
    @opportunity = Opportunity.find_by_pub_key(@document.opportunity_key)
    
    @companies = Contact.companies
    @contacts = Contact.people
    
    gon.companies = @companies.to_json(:include => [:addresses, :phones, :emails])
    gon.contacts = @contacts.to_json(:include => [:addresses, :phones, :emails])
    
    gon.document = @document
    
  end
  
  def update
    @document = Document.find_by_pub_key(params[:id])
    
    respond_to do |format|
      format.html {
        if @document.update_attributes(params[:document])
          flash[:success] = "Document updated"
          redirect_to document_path(@document.pub_key)
        else
          render 'edit'
        end
      }
      
      format.json {
        if @document
          @document.name = params[:name]
          # @document.description = params[:description]
          #           # @template.description = params[:description]
          #           #           @template.instructions = params[:instructions]
          #           #           
          #           @document.total_purchase = params[:total_purchase]
          #           @document.total_hourly = params[:total_hourly]
          #           @document.total_daily = params[:total_daily]
          #           @document.total_weekly = params[:total_weekly]
          #           @document.total_monthly = params[:total_monthly]
          #           @document.total_quarterly = params[:total_quarterly]
          #           @document.total_yearly = params[:total_yearly]
          
          if @document.save
            render :json => @document.to_json(:include => [])
          else
            render :json => "false", :status => :unprocessable_entity
          end
        else
          render :json => "false", :status => :unprocessable_entity
        end
      }
    end
  end
  
  def destroy
    @document = Document.find_by_pub_key(params[:id])
    @document.destroy
    redirect_back_or opportunity_path(id: @document.opportunity.pub_key)
  end
  
  
  def preview
    respond_to do |format|
      format.html {
        @document = Document.find_by_pub_key(params[:id])
        @opportunity = Opportunity.find_by_pub_key(@document.opportunity_key)
        
        gon.document = @document.to_json()
        gon.document_items = @document.document_items.to_json(:include => {:catalog_item => {:include => [:child_items]}})
        gon.opportuity = @opportunity.to_json()
        
        render :layout => 'blank'
      }
    end
  end
  
  def download
    respond_to do |format|
      format.pdf do
        @document = Document.find_by_pub_key(params[:id])
        @opportunity = Opportunity.find_by_pub_key(@document.opportunity_key)
        
        render :layout => 'pdf.html', :pdf => @document.name
      end
    end
  end
  
  def email
    @document = Document.find_by_pub_key(params[:id])
    DocumentMailer.email(@document).deliver
    render :nothing => true
  end
  
  
  
  
  
  
  
  
  def choose_template
    if request.post?
      @document = Document.find_by_pub_key(params[:id])
      @document.template_key = params[:document][:template_key]
      
      @template = Template.find_by_pub_key(params[:document][:template_key])
      
      if @template
         @template.template_items.each do |item|
           doc_item = @document.document_items.build(
             name: item.name, 
             part_number: item.part_number,
             quantity: item.quantity,
             unit_price: item.unit_price,
             unit_price_unit: item.unit_price_unit,
             total: item.total,
             total_unit: item.total_unit,
             description: item.description,
             is_group_heading: item.is_group_heading,
             catalog_item_key: item.catalog_item_key,
             sort_order: item.sort_order,
             not_in_total: item.not_in_total,
             hide_package_contents: item.hide_package_contents
           )
           doc_item.save
         end
       # else
       #          @template = Templates.find_by_document_type_key(params[:document_type], :conditions => {:is_document_type_default => true})
       end
      
      @document.save!
      
      redirect_to document_path(id: @document.pub_key)
    else
      @document = Document.find_by_pub_key(params[:id])
      @opportunity = @document.opportunity
    
      @templates = Template.all
    
      gon.templates = @templates.to_json(:include => [:document_type, :template_items])
    end
  end
end
