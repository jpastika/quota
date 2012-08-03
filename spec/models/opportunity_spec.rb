require 'spec_helper'

describe Opportunity do
  before(:each) do
     @user = FactoryGirl.create(:user)
     @account = @user.account
     @opp = @user.created_opportunities.build(name: "Opportunity 1", owner_key: @user.pub_key, account_key: @account.pub_key)
  end
  
  
  subject { @opp }
  
  it { should respond_to(:name) }
  it { should respond_to(:estimated_close) }
  it { should respond_to(:estimated_value_interval) }
  it { should respond_to(:actual_close) }
  it { should respond_to(:milestone_key) }
  it { should respond_to(:probability) }
  it { should respond_to(:owner_key) }
  it { should respond_to(:creator_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:account) }
  it { should respond_to(:owner) }
  it { should respond_to(:created_by) }
  it { should respond_to(:documents) }
  it { should respond_to(:description) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @opp.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @opp.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  describe "owned by user" do
    before { @opp.save }
    
    it { should respond_to(:owner) }
    its(:owner) { should == @user }
  end
  
  describe "created by user" do
    before { @opp.save }
    
    it { should respond_to(:created_by) }
    its(:created_by) { should == @user }
  end
  
  describe "when account key is not present" do
    before { @opp.account_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when owner key is not present" do
    before { @opp.owner_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when creator key is not present" do
    before { @opp.creator_key = nil }
    
    it { should_not be_valid }
  end
  
end
