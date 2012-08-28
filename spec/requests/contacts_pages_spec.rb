require 'spec_helper'

describe "Contacts Pages" do

  subject { page }

  before {sign_in FactoryGirl.create(:user)}

  describe "index" do
    before { visit contacts_path }
  
    it { should have_selector('title', text: 'Contacts') }
    it { should have_link('Add contact', href: new_contact_path) }
  end

  describe "new contact" do
    before { 
      visit new_contact_path 
    }
  
    let(:submit){"Add contact"}
  
    describe "with invalid information" do
      it "should not create a contact" do
        expect{ click_button submit }.not_to change(Contact, :count)
      end
    
      describe "error messages" do
        before {click_button submit}
      
        it{should have_selector('title', text: 'Add Contact')}
        it{should have_content('problem')}
      end
    end
  
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example Contact"
        choose("Person")
        # fill_in "Email", with: "user2@example.com"
      end

      it "should create a contact" do
        expect{ click_button submit }.to change(Contact, :count).by(1)
      end

      describe "after saving the contact" do
        before {click_button submit}

        it {should have_selector('title', text: 'Contacts')}
        it {should have_link('Sign out')}
      end
    end
  end
end
