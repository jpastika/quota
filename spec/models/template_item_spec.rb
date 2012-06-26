require 'spec_helper'

describe TemplateItem do
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @template = @account.templates.build(name: "Template 1", document_type: @account.document_types.first)
     @template.save
     @item = @account.template_items.build(name: "Item 1", unit_price: "50", template_key: @template.pub_key)
  end
  
  #before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @item }
  
  it { should respond_to(:name) }
  it { should respond_to(:part_number) }
  it { should respond_to(:quantity) }
  it { should respond_to(:unit_price) }
  it { should respond_to(:discount) }
  it { should respond_to(:is_taxable) }
  it { should respond_to(:is_discountable) }
  it { should respond_to(:total) }
  it { should respond_to(:notes) }
  it { should respond_to(:sort_order) }
  it { should respond_to(:is_hidden) }
  it { should respond_to(:document_item_type_key) }
  it { should respond_to(:day_rate) }
  it { should respond_to(:week_rate) }
  it { should respond_to(:month_rate) }
  it { should respond_to(:year_rate) }
  it { should respond_to(:buyout) }
  it { should respond_to(:description) }
  it { should respond_to(:term_length) }
  it { should respond_to(:term_unit) }
  it { should respond_to(:unit_price_unit) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:template_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:catalog_item_key) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:parent_item_key) }
  it { should respond_to(:account) }
  it { should respond_to(:template) }
  it { should respond_to(:catalog_item) }
  it { should respond_to(:parent_item) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @item.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @item.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  
end
  