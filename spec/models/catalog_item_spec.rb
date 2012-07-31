require 'spec_helper'

describe CatalogItem do
  
  before(:each) do
     @user = FactoryGirl.create(:user)
     @account = @user.account
     @item = @account.catalog_items.build(name: "Item 1", list_price: "50")
  end
  
  #before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @item }
  
  it { should respond_to(:name) }
  it { should respond_to(:part_number) }
  it { should respond_to(:manufacturer) }
  it { should respond_to(:description) }
  it { should respond_to(:list_price) }
  it { should respond_to(:cost) }
  it { should respond_to(:is_recurring) }
  it { should respond_to(:recurring_unit) }
  it { should respond_to(:is_taxable) }
  it { should respond_to(:is_subscription) }
  it { should respond_to(:subscription_length) }
  it { should respond_to(:subscription_length_unit) }
  it { should respond_to(:list_price_unit) }
  it { should respond_to(:day_rate) }
  it { should respond_to(:week_rate) }
  it { should respond_to(:month_rate) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:account) }
  
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
