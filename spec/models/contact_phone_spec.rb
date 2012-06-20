require 'spec_helper'

describe ContactPhone do
  
    
  before(:each) do
     @person = FactoryGirl.create(:person)
     @account = @person.account
     @phone = @account.contact_phones.build(name: "Office", val: "123-123-1234", contact_key: @person.pub_key)
  end
  
  
  
  subject { @phone }
  
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
    before { @phone.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:contact) }
    its(:account) { should == @account }
    its(:contact) { should == @person }
  end
  
  describe "when account key is not present" do
    before { @phone.account_key = nil }
    
    it { should_not be_valid }
  end
  
end