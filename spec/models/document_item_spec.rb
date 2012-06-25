require 'spec_helper'

describe DocumentItem do
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @opp = @member.created_opportunities.build(name: "Opportunity 1", owner_key: @member.pub_key, account_key: @account.pub_key)
     @opp.save
     @document = @opp.documents.build(name: "Quote 1", account_key: @account.pub_key, creator_key: @member.pub_key, document_type: "Quote")
     @document.save
     @item = @account.document_items.build(name: "Item 1", unit_price: "50", document_key: @document.pub_key)
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
  it { should respond_to(:document_item_type) }
  it { should respond_to(:day_rate) }
  it { should respond_to(:week_rate) }
  it { should respond_to(:month_rate) }
  it { should respond_to(:year_rate) }
  it { should respond_to(:buyout) }
  it { should respond_to(:serial_number) }
  it { should respond_to(:description) }
  it { should respond_to(:term_length) }
  it { should respond_to(:term_unit) }
  it { should respond_to(:unit_price_unit) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:document_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:catalog_item_key) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:parent_item_key) }
  it { should respond_to(:account) }
  it { should respond_to(:document) }
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
  