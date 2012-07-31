require 'spec_helper'

describe ContactType do
  before(:each) do
     @user = FactoryGirl.create(:user)
     @account = @user.account
     @contact_type = @account.contact_types.build(name: "Company")
  end
  
  #before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @contact_type }
  
  it { should respond_to(:name) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @contact_type.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @contact_type.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  
end
