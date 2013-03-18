class TemplateItemsController < ApplicationController
  before_filter :signed_in!, :check_disabled!
  
  def create
    respond_to do |format|
      format.html {
        
      }
      format.json {
        # handle is_group_heading checkbox
        if params[:template_item][:is_group_heading] != "true" && params[:template_item][:is_group_heading] != true
          params[:template_item][:is_group_heading] = false
        end

        # handle not_in_total checkbox
        if params[:template_item][:not_in_total] != "true" && params[:template_item][:not_in_total] != true
          params[:template_item][:not_in_total] = false
        end

        # handle hide_package_contents checkbox
        if params[:template_item][:hide_package_contents] != "true" && params[:template_item][:hide_package_contents] != true
          params[:template_item][:hide_package_contents] = false
        end

        @template_item = TemplateItem.create(params[:template_item])
        @template_item.unit_price = params[:template_item][:unit_price].to_s.delete ","
        @template_item.total = params[:template_item][:total].to_s.delete ","
        
        
        if @template_item.save
          render :json => @template_item.to_json(:include => [:catalog_item])
        else
          render :json => "false"
        end
      }
    end
  end
  
  def edit
    # gon.companies = @companies
    #     gon.milestones = @milestones
    
    @template_item = TemplateItem.find_by_pub_key(params[:id])
    gon.template_item = @template_item
    
  end
  
  def update
    @template_item = TemplateItem.find_by_pub_key(params[:id])
    
    respond_to do |format|
      format.html {
        # handle is_group_heading checkbox
        if params[:template_item][:is_group_heading] != "true" && params[:template_item][:is_group_heading] != true
          params[:template_item][:is_group_heading] = false
        end

        # handle not_in_total checkbox
        if params[:template_item][:not_in_total] != "true" && params[:template_item][:not_in_total] != true
          params[:template_item][:not_in_total] = false
        end

        # handle hide_package_contents checkbox
        if params[:template_item][:hide_package_contents] != "true" && params[:template_item][:hide_package_contents] != true
          params[:template_item][:hide_package_contents] = false
        end

        if @template_item.update_attributes(params[:template_item])
          @template_item.unit_price = params[:template_item][:unit_price].to_s.delete ","
          @template_item.total = params[:template_item][:total].to_s.delete ","
          @template.save
          flash[:success] = "Template Item updated"
          redirect_to template_item_path(@template_item.pub_key)
        else
          render 'edit'
        end
      }
      
      format.json {
        if @template_item
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
          
          @template_item.is_group_heading = params[:is_group_heading]
          @template_item.not_in_total = params[:not_in_total]
          @template_item.hide_package_contents = params[:hide_package_contents]
          @template_item.name = params[:name]
          @template_item.part_number = params[:part_number]
          @template_item.unit_price = params[:unit_price].to_s.delete ","
          @template_item.unit_price_unit = params[:unit_price_unit]
          @template_item.quantity = params[:quantity]
          @template_item.total_unit = params[:total_unit]
          @template_item.total = params[:total].to_s.delete ","
          @template_item.description = params[:description]
          @template_item.catalog_item_key = params[:catalog_item_key]
          @template_item.sort_order = params[:sort_order]
          
          if @template_item.save
            render :json => @template_item.to_json(:include => [])
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
        @template_item = TemplateItem.find_by_pub_key(params[:id])
        @template_item.destroy
        redirect_back_or templates_path
      }
      format.json {
        @template_item = TemplateItem.find_by_pub_key(params[:id])      
        if @template_item.destroy
          render :json => @template_item
        else
          render :json => "false"
        end
      }
    end
  end
  
  def filter_by_name_or_part_number
    respond_to do |format|
      format.html {
        @template_items = TemplateItem.find_by_name_or_part_number(params[:filter])
      }
      format.json { 
        @template_items = TemplateItem.find_by_name_or_part_number(params[:filter])
        
        render :json => @template_items.to_json()
      }
    end
  end
  
  def reorder
    respond_to do |format|
      format.json {
        @template_items = params[:_json]
                
        @template_items.each do |item|
          template_item = TemplateItem.find_by_pub_key(item[:pub_key])
          template_item.sort_order = item[:sort_order]
          if !template_item.save
            render :json => "false"
          end
        end
          
        render :json => "true"
      }
    end
  end
end
