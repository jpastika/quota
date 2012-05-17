require 'spec_helper'

describe Member do
  
  let(:account){ FactoryGirl.create(:account) }
  let(:user){ FactoryGirl.create(:user) }
  let(:member) do
    account.members.build(user_id: user.id)
  end
  
  subject { member }
  
  it { should respond_to(:pub_key) }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Member.new(account_id: account)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "related account and user" do
    before { member.save }
    
    it { should respond_to(:account) }
    it { should respond_to(:user) }
    its(:account) { should == account }
    its(:user) { should == user }
  end
  
  describe "when account id is not present" do
    before { member.account_id = nil }
    
    it { should_not be_valid }
  end
  
  describe "when user id is not present" do
    before { member.user_id = nil }
    
    it { should_not be_valid }
  end
  
end