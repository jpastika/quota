require 'spec_helper'

describe Template do
  before(:each) do
     @member = FactoryGirl.create(:member)
     @account = @member.account
     @user = @member.user
     @tpl = @account.templates.build(name: "Template 1", document_type: @account.document_types.first)
  end
  
  #before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @tpl }
  
  it { should respond_to(:name) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:is_document_type_default) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:document_type_key) }
  it { should respond_to(:document_type) }
  it { should respond_to(:account_key) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @tpl.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "related account" do
    before { @tpl.save }
    
    it { should respond_to(:account) }
    its(:account) { should == @account }
  end
  
  
end
  