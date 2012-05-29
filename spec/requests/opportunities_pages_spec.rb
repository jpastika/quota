require 'spec_helper'

describe "Opportunities Pages" do
  subject { page }
  
  let(:member){ FactoryGirl.create(:member) }
  before {sign_in member}
  
  describe "index" do
    before do
      FactoryGirl.create(:opportunity, account: member.account)
      visit opportunities_path
    end
    
    it { should have_selector('title', text: 'Opportunities') }
    it { should have_link('Add opportunity', href: new_opportunity_path) }
    
    describe "when delete link is clicked" do
      
      it "should delete an opportunity" do
        expect { click_link "delete" }.should change(Opportunity, :count).by(-1)
      end
    end
  end
  
  describe "new" do
    before { visit new_opportunity_path }
    
    it { should have_selector('title', text: 'Opportunity') }
    
  end
end
