require 'spec_helper'

describe Document do
  before do
     @user = FactoryGirl.create(:user)
     @account = @user.account
     @opp = @user.created_opportunities.build(name: "Opportunity 1", owner_key: @user.pub_key, account_key: @account.pub_key)
     @opp.save
     @document = @opp.documents.build(name: "Quote 1", account_key: @account.pub_key, creator_key: @user.pub_key, document_type: @account.document_types.first)
  end
  
  subject { @document }
  
  it { should respond_to(:billing_city) }
  it { should respond_to(:billing_country) }
  it { should respond_to(:billing_county) }
  it { should respond_to(:billing_state) }
  it { should respond_to(:billing_street1) }
  it { should respond_to(:billing_street2) }
  it { should respond_to(:billing_zip) }
  it { should respond_to(:company_fax) }
  it { should respond_to(:company_key) }
  it { should respond_to(:company_name) }
  it { should respond_to(:company_phone) }
  it { should respond_to(:contact_email) }
  it { should respond_to(:contact_key) }
  it { should respond_to(:contact_name) }
  it { should respond_to(:contact_phone) }
  it { should respond_to(:creator_key) }
  it { should respond_to(:document_type_key) }
  it { should respond_to(:is_draft) }
  it { should respond_to(:name) }
  it { should respond_to(:notes_customer) }
  it { should respond_to(:notes_internal) }
  it { should respond_to(:opportunity_key) }
  it { should respond_to(:po) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:reference_id) }
  it { should respond_to(:rep_key) }
  it { should respond_to(:shipping_city) }
  it { should respond_to(:shipping_country) }
  it { should respond_to(:shipping_county) }
  it { should respond_to(:shipping_state) }
  it { should respond_to(:shipping_street1) }
  it { should respond_to(:shipping_street2) }
  it { should respond_to(:shipping_zip) }
  it { should respond_to(:total_grand) }
  it { should respond_to(:total_recurring_monthly) }
  it { should respond_to(:total_recurring_yearly) }
  it { should respond_to(:total_shipping_handling) }
  it { should respond_to(:total_subtotal) }
  it { should respond_to(:total_tax) }
  it { should respond_to(:total_tax_percent) }
  it { should respond_to(:account) }
  it { should respond_to(:opportunity) }
  it { should respond_to(:document_type) }
  it { should respond_to(:created_by) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @document.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @document.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  describe "created by user" do
    before { @document.save }
    
    it { should respond_to(:created_by) }
    its(:created_by) { should == @user }
  end
  
  describe "when account key is not present" do
    before { @document.account_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when opportunity key is not present" do
    before { @document.opportunity_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when creator key is not present" do
    before { @document.creator_key = nil }
    
    it { should_not be_valid }
  end
end
