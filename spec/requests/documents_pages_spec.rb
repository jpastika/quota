require 'spec_helper'

describe "Document Pages" do
  subject { page }
  
  let(:member){ FactoryGirl.create(:member) }
  let(:opportunity){FactoryGirl.create(:opportunity, account: member.account)}
  
  before do
    sign_in member
    visit opportunity_path(opportunity.pub_key)
  end
  
  describe "new" do
    before do
      click_link "Quote"
    end
    
    it { should have_selector('h3', text: opportunity.name) }
    # describe "when delete link is clicked" do
    #       
    #       it "should delete an opportunity" do
    #         expect { click_link "Delete" }.should change(Opportunity, :count).by(-1)
    #       end
    #     end
  end
  
  # describe "new" do
  #     before { visit new_opportunity_path }
  #     
  #     it { should have_selector('title', text: 'Opportunity') }
  #     
  #   end
  #   
  #   describe "show" do
  #     let(:opportunity){ FactoryGirl.create(:opportunity, account: member.account) }
  #     
  #     before do
  #       visit opportunity_path(opportunity.pub_key)
  #       
  #     end
  #     
  #     it { should have_selector('title', text: "Opportunity - #{opportunity.name}") }
  #   end
end
  