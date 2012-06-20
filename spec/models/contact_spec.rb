require 'spec_helper'

describe Contact do
  
    
  before(:each) do
     @person = FactoryGirl.create(:person)
     @company = FactoryGirl.create(:company)
     @account = @person.account
  end
  
  
  
  subject { @person }
  
  it { should respond_to(:pub_key) }
  it { should respond_to(:name) }
  it { should respond_to(:title) }
  it { should respond_to(:company_key) }
  it { should respond_to(:account_key) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:phones) }
  it { should respond_to(:emails) }
  it { should respond_to(:urls) }
  it { should respond_to(:addresses) }
  it { should respond_to(:company) }
  it { should respond_to(:people) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Contact.new(account_key: @account.pub_key)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "related account and company" do
    before { @person.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:company) }
    its(:account) { should == @account }
  end
  
  describe "when account key is not present" do
    before { @person.account_key = nil }
    
    it { should_not be_valid }
  end
  
end