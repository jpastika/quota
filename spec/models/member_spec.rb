require 'spec_helper'

describe Member do
  
    
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
  end
  
  
  
  subject { @member }
  
  it { should respond_to(:pub_key) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:is_disabled) }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Member.new(account_key: @account.pub_key)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "related account and user" do
    before { @member.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:user) }
    its(:account) { should == @account }
    its(:user) { should == @user }
  end
  
  describe "when account key is not present" do
    before { @member.account_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "when user key is not present" do
    before { @member.user_key = nil }
    
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before { @member.save }
    its(:remember_token) { should_not be_blank }
  end
  
end
