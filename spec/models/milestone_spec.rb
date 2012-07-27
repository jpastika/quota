require 'spec_helper'

describe Milestone do
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @milestone = @account.milestones.build(name: "Quote", probability: "0.25")
  end
  
  #before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @milestone }
  
  it { should respond_to(:name) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @milestone.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @milestone.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  
end
