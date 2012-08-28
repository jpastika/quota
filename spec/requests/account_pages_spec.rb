require 'spec_helper'

describe "Account pages" do
  
  subject { page }
  
  describe "signup page" do
    before {  visit signup_path }
    
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe "signup" do
    before { visit signup_path }
    
    let(:submit) { "Create account" }
    
    describe "with invalid information" do
      it "should not create an account" do
        expect { click_button submit }.not_to change(Account, :count)
      end
      
      it "should not create an user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      # it "should not create an member" do
      #         expect { click_button submit }.not_to change(Member, :count)
      #       end
    end
    
    describe "with valid information" do
      before do
        fill_in "Your name",        with: "Bob Dole"
        fill_in "Email address",        with: "aaa@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Company", with: "AAA Company"
        fill_in "Site address",    with: "aaa"
      end

      it "should create an account" do
        expect { click_button submit }.to change(Account, :count).by(1)
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      # it "should create a member" do
      #         expect { click_button submit }.to change(Member, :count).by(1)
      #       end
    end
  end
end
