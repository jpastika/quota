require 'spec_helper'

describe User do
  
  #before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }
  before { @user = User.new(name: "John Doe", email: "jdoe@example.com", password: "foobar") }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  #it { should respond_to(:password_confirmation) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:is_disabled) }
  it { should respond_to(:members) }
  it { should respond_to(:accounts) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  
  #describe "when name is not present" do
  #  before { @user.name = " " }
  #  
  #  it { should_not be_valid }
  #end
  
  describe "when email is not present" do
    before { @user.email = " " }
    
    it { should_not be_valid }
  end 
  
  #describe "when name is too long" do
  #  before{ @user.name = "a" * 51}
  #  
  #  it { should_not be_valid }
  #end
  
  describe "when email is invalid" do
    it "should be invalid" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      emails.each do |invalid_email|
        @user.email = invalid_email
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email is valid" do
    it "should be valid" do
      emails = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |valid_email|
        @user.email = valid_email
        @user.should be_valid
      end
    end
  end
  
  describe "when password is not present" do
    #before { @user.password = @user.password_confirmation = " " }
    before { @user.password = " " }
    
    it { should_not be_valid }
  end
  
  #describe "when password does not match confirmation" do
  #  before { @user.password_confirmation = "mismatch" }
  #  
  #  it { should_not be_valid }
  #end
  
  #describe "when password confirmation is nil" do
  #  before { @user.password_confirmation = nil }
  #  
  #  it { should_not be_valid }
  #end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
end
