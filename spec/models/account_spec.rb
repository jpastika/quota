require 'spec_helper'

describe Account do
  
  before { @account = Account.new(name: "XYZ Company", subdomain: "xyz") }
  
  subject { @account }
  
  it { should respond_to(:name) }
  it { should respond_to(:subdomain) }
    it { should respond_to(:pub_key) }
    it { should respond_to(:is_disabled) }
    # it { should respond_to(:members) }
    it { should respond_to(:users) }
    it { should respond_to(:catalog_items) }
    it { should respond_to(:opportunities) }
    # it { should respond_to(:quotes) }
    it { should respond_to(:documents) }
    it { should respond_to(:document_items) }
    it { should respond_to(:sales_reps) }
    it { should respond_to(:contact_types) }
    it { should respond_to(:contacts) }
    it { should respond_to(:contact_phones) }
    it { should respond_to(:contact_emails) }
    it { should respond_to(:contact_urls) }
    it { should respond_to(:contact_addresses) }
    it { should respond_to(:document_types) }
    it { should respond_to(:templates) }
    it { should respond_to(:template_items) }
    it { should respond_to(:opportunity_contacts) }
    it { should respond_to(:repize!) }
  
  it { should be_valid }
  
  
  describe "when name is not present" do
    before{ @account.name = " " }
    
    it { should_not be_valid }
  end
  
  describe "when subdomain is not present" do
    before{ @account.subdomain = " " }
    
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before{ @account.name = "a" * 51}
    
    it { should_not be_valid }
  end
  
  describe "when subdomain is invalid" do
    it "should be invalid" do
      subdomains = %w[aa@a aa.a aa=aa aa+aa aa,aa]
      subdomains.each do |invalid_subdomain|
        @account.subdomain = invalid_subdomain
        @account.should_not be_valid
      end
    end
  end
  
  describe "when subdomain is valid" do
    it "should be valid" do
      subdomains = %w[aaa aa_aa aa-aa aa11]
      subdomains.each do |valid_subdomain|
        @account.subdomain = valid_subdomain
        @account.should be_valid
      end
    end
  end
  
  describe "when subdomain is already taken" do
    before do
      account_with_same_subdomain = @account.dup
      account_with_same_subdomain.subdomain = @account.subdomain.upcase
      account_with_same_subdomain.save
    end
    
    it { should_not be_valid }
  end
  
  # describe "repizing" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     
  #     before do
  #       @account.save
  #       @account.repize!(user)
  #     end
  #     
  #     its(:users) { should include(user) }
  #   end
  
end
