require 'spec_helper'

describe SalesRep do
  
    
  before(:each) do
     @salesrep = FactoryGirl.create(:sales_rep)
     @account = @salesrep.account
     @member = @salesrep.member
  end
  
  
  
  subject { @salesrep }
  
  it { should respond_to(:pub_key) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:is_disabled) }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        SalesRep.new(account_id: @account)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "related account and user" do
    before { @salesrep.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:member) }
    its(:account) { should == @account }
    its(:member) { should == @member }
  end
  
  describe "when account key is not present" do
    before { @salesrep.account_key = nil }
    
    it { should_not be_valid }
  end
  
end