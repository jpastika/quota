class DocumentItemsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def create
    respond_to do |format|
      format.html {
        
      }
      format.json {
        # handle is_group_heading checkbox
        if params[:document_item][:is_group_heading] != "true" && params[:document_item][:is_group_heading] != true
          params[:document_item][:is_group_heading] = false
        end

        # handle not_in_total checkbox
        if params[:document_item][:not_in_total] != "true" && params[:document_item][:not_in_total] != true
          params[:document_item][:not_in_total] = false
        end

        # handle hide_package_contents checkbox
        if params[:document_item][:hide_package_contents] != "true" && params[:document_item][:hide_package_contents] != true
          params[:document_item][:hide_package_contents] = false
        end

        @document_item = DocumentItem.create(params[:document_item])
        
        @document_item.unit_price = params[:document_item][:unit_price].to_s.delete ","
        @document_item.total = params[:document_item][:total].to_s.delete ","
        if @document_item.save
          render :json => @document_item.to_json(:include => [:catalog_item])
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    # gon.companies = @companies
    #     gon.milestones = @milestones
    
    @document_item = DocumentItem.find_by_pub_key(params[:id])
    gon.document_item = @document_item
    
  end
  
  def update
    @document_item = DocumentItem.find_by_pub_key(params[:id])
    
    respond_to do |format|
      format.html {
        # handle is_group_heading checkbox
        if params[:document_item][:is_group_heading] != "true" && params[:document_item][:is_group_heading] != true
          params[:document_item][:is_group_heading] = false
        end

        # handle not_in_total checkbox
        if params[:document_item][:not_in_total] != "true" && params[:document_item][:not_in_total] != true
          params[:document_item][:not_in_total] = false
        end

        # handle hide_package_contents checkbox
        if params[:document_item][:hide_package_contents] != "true" && params[:document_item][:hide_package_contents] != true
          params[:document_item][:hide_package_contents] = false
        end

        if @document_item.update_attributes(params[:document_item])
          @document_item.unit_price = params[:document_item][:unit_price].to_s.delete ","
          @document_item.total = params[:document_item][:total].to_s.delete ","
          
          @document_item.save
          flash[:success] = "Document Item updated"
          redirect_to document_item_path(@document_item.pub_key)
        else
          render 'edit'
        end
      }
      
      format.json {
        if @document_item
          if params[:is_group_heading] != "true" && params[:is_group_heading] != true
            params[:is_group_heading] = false
          end

          # handle not_in_total checkbox
          if params[:not_in_total] != "true" && params[:not_in_total] != true
            params[:not_in_total] = false
          end
          
          # handle hide_package_contents checkbox
          if params[:hide_package_contents] != "true" && params[:hide_package_contents] != true
            params[:hide_package_contents] = false
          end
          
          @document_item.is_group_heading = params[:is_group_heading]
          @document_item.not_in_total = params[:not_in_total]
          @document_item.hide_package_contents = params[:hide_package_contents]
          @document_item.name = params[:name]
          @document_item.part_number = params[:part_number]
          @document_item.unit_price = params[:unit_price].to_s.delete ","
          @document_item.unit_price_unit = params[:unit_price_unit]
          @document_item.quantity = params[:quantity]
          @document_item.total_unit = params[:total_unit]
          @document_item.total = params[:total].to_s.delete ","
          @document_item.description = params[:description]
          @document_item.catalog_item_key = params[:catalog_item_key]
          @document_item.sort_order = params[:sort_order]
          
          if @document_item.save
            render :json => @document_item.to_json(:include => [])
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
    respond_to do |format|
      format.html {
        @document_item = DocumentItem.find_by_pub_key(params[:id])
        @document_item.destroy
        redirect_back_or documents_path
      }
      format.json {
        @document_item = DocumentItem.find_by_pub_key(params[:id])      
        if @document_item.destroy
          render :json => @document_item
        else
          render :json => "false"
        end
      }
    end
  end
  
  def filter_by_name_or_part_number
    respond_to do |format|
      format.html {
        @document_items = DocumentItem.find_by_name_or_part_number(params[:filter])
      }
      format.json { 
        @document_items = DocumentItem.find_by_name_or_part_number(params[:filter])
        
        render :json => @document_items.to_json()
      }
    end
  end
  
  def reorder
    respond_to do |format|
      format.json {
        @document_items = params[:_json]
                
        @document_items.each do |item|
          document_item = DocumentItem.find_by_pub_key(item[:pub_key])
          document_item.sort_order = item[:sort_order]
          if !document_item.save
            render :json => "false"
          end
        end
          
        render :json => "true"
      }
    end
  end
end
