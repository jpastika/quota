require 'spec_helper'

describe ContactUrl do
  
    
  before(:each) do
     @person = FactoryGirl.create(:person)
     @account = @person.account
     @url = @account.contact_urls.build(name: "Work", val: "www.abcco.com", contact_key: @person.pub_key)
  end
  
  
  
  subject { @url }
  
  it { should respond_to(:pub_key) }
  it { should respond_to(:name) }
  it { should respond_to(:val) }
  it { should respond_to(:contact_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:is_disabled) }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Contact.new(account_key: @account.pub_key)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "related account and contact" do
    before { @url.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:contact) }
    its(:account) { should == @account }
    its(:contact) { should == @person }
  end
  
  describe "when account key is not present" do
    before { @url.account_key = nil }
    
    it { should_not be_valid }
  end
  
end