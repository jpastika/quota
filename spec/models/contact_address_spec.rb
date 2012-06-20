require 'spec_helper'

describe ContactAddress do
  
    
  before(:each) do
     @person = FactoryGirl.create(:person)
     @account = @person.account
     @address = @account.contact_addresses.build(name: "Work", street1: "19313 US Hwy 41", street2: "", city: "Lutz", state: "FL", zip: "33549", country: "USA", county: "Hillsborough", contact_key: @person.pub_key)
  end
  
  
  
  subject { @address }
  
  it { should respond_to(:pub_key) }
  it { should respond_to(:name) }
  it { should respond_to(:street1) }
  it { should respond_to(:street2) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:country) }
  it { should respond_to(:county) }
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
    before { @address.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:contact) }
    its(:account) { should == @account }
    its(:contact) { should == @person }
  end
  
  describe "when account key is not present" do
    before { @address.account_key = nil }
    
    it { should_not be_valid }
  end
  
end