require 'spec_helper'

describe "Member Pages" do
  
  # subject { page }
  #   
  #   before {sign_in FactoryGirl.create(:member)}
  #   
  #   describe "index" do
  #     before { visit members_path }
  #     
  #     it { should have_selector('title', text: 'Members') }
  #     it { should have_link('Add member', href: new_member_path) }
  #   end
  #   
  #   describe "new member" do
  #     before { visit new_member_path }
  #     
  #     let(:submit){"Add member"}
  #     
  #     describe "with invalid information" do
  #       it "should not create a user" do
  #         expect{ click_button submit }.not_to change(User, :count)
  #       end
  #       
  #       it "should not create a member" do
  #         expect{ click_button submit }.not_to change(Member, :count)
  #       end
  #       
  #       describe "error messages" do
  #         before {click_button submit}
  #         
  #         it{should have_selector('title', text: 'Add Member')}
  #         it{should have_content('error')}
  #       end
  #     end
  #     
  #     describe "with valid information" do
  #       describe "when user does not already exist" do
  #         before do
  #           fill_in "Name", with: "Example User 2"
  #           fill_in "Email", with: "user2@example.com"
  #           fill_in "Password", with: "foobar"
  #         end
  # 
  #         it "should create a user" do
  #           expect{ click_button submit }.to change(User, :count).by(1)
  #         end
  # 
  #         it "should create a member" do
  #           expect{ click_button submit }.to change(Member, :count).by(1)
  #         end
  # 
  #         describe "after saving the member" do
  #           before {click_button submit}
  # 
  #           it {should have_selector('title', text: 'Members')}
  #           it {should have_link('Sign out')}
  #         end
  #       end
  #       
  #       describe "when user already exists" do
  #         before do
  #           @member = FactoryGirl.create(:member)
  #           @account = @member.account
  #           @user = @member.user
  #           
  #           @user2 = FactoryGirl.create(:user)
  #           
  #           sign_in @member
  #           
  #           visit new_member_path
  #           
  #           fill_in "Name", with: @user2.name
  #           fill_in "Email", with: @user2.email
  #           fill_in "Password", with: @user2.password
  #         end
  # 
  #         it "should not create a user" do
  #           expect{ click_button submit }.not_to change(User, :count)
  #         end
  # 
  #         it "should create a member" do
  #           expect{ click_button submit }.to change(Member, :count).by(1)
  #         end
  # 
  #         describe "after saving the member" do
  #           before {click_button submit}
  # 
  #           it {should have_selector('title', text: 'Members')}
  #           it {should have_link('Sign out')}
  #         end
  #       end
  #     end
  # end
end
