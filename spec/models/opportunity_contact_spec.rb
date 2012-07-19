require 'spec_helper'

describe OpportunityContact do
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @person = FactoryGirl.create(:person)
     @opp = @member.created_opportunities.build(name: "Opportunity 1", owner_key: @member.pub_key, account_key: @account.pub_key)
     @opp.save
     @opp_contact = @account.opportunity_contacts.build(opportunity_key: @opp.pub_key, contact_key: @person.pub_key)
  end
  
  subject { @opp_contact }
  
  it { should respond_to(:opportunity_key) }
  it { should respond_to(:contact_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:opportunity) }
  it { should respond_to(:contact) }
  
  it { should be_valid }
  
  describe "related account" do
    before { @opp_contact.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  describe "when account key is not present" do
    before { @opp_contact.account_key = nil }
    
    it { should_not be_valid }
  end
  
end
