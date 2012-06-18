require 'spec_helper'

describe "Sales Reps Pages" do
  
  subject { page }
  
  before {sign_in FactoryGirl.create(:member)}
  
  describe "index" do
    before { visit sales_reps_path }
    
    it { should have_selector('title', text: 'Sales Reps') }
    it { should have_link('Add rep', href: new_sales_rep_path) }
  end
  
  describe "new rep" do
    before { 
      visit new_sales_rep_path 
    }
    
    let(:submit){"Add rep"}
    
    describe "with invalid information" do
      it "should not create a rep" do
        expect{ click_button submit }.not_to change(SalesRep, :count)
      end
      
      describe "error messages" do
        before {click_button submit}
        
        it{should have_selector('title', text: 'Add Sales Rep')}
        it{should have_content('problem')}
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User 2"
        fill_in "Email", with: "user2@example.com"
      end

      it "should create a rep" do
        expect{ click_button submit }.to change(SalesRep, :count).by(1)
      end

      describe "after saving the rep" do
        before {click_button submit}

        it {should have_selector('title', text: 'Sales Reps')}
        it {should have_link('Sign out')}
      end
    end
  end
end
