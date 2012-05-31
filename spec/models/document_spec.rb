require 'spec_helper'

describe Document do
  before do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @opp = @member.created_opportunities.build(name: "Opportunity 1", owner_key: @member.pub_key, account_key: @account.pub_key)
     @opp.save
     @doc = @opp.documents.build(name: "Document 1", account_key: @account.pub_key, creator_key: @member.pub_key)
  end
  
  subject { @doc }
  
  it { should respond_to(:name) }
  it { should respond_to(:is_draft) }
  it { should respond_to(:opportunity_key) }
  it { should respond_to(:creator_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:account) }
  it { should respond_to(:opportunity) }
  it { should respond_to(:created_by) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @doc.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @doc.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  describe "created by member" do
    before { @doc.save }
    
    it { should respond_to(:created_by) }
    its(:created_by) { should == @member }
  end
  
  describe "when account key is not present" do
    before { @doc.account_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when opportunity key is not present" do
    before { @doc.opportunity_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when creator key is not present" do
    before { @doc.creator_key = nil }
    
    it { should_not be_valid }
  end
end
