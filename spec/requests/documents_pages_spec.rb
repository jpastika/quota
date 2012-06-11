require 'spec_helper'

describe "Document Pages" do
  subject { page }
  
  let(:member){ FactoryGirl.create(:member) }
  let(:opp){ FactoryGirl.create(:opportunity, account: member.account) }
  before {sign_in member}
  
  describe "index" do
    before do
      
      FactoryGirl.create(:document, account: member.account, opportunity: opp)
      visit documents_path
    end
    
    it { should have_selector('title', text: 'Documents') }
    
    describe "when delete link is clicked" do
      
      it "should delete an document" do
        expect { click_link "Delete" }.should change(Document, :count).by(-1)
      end
    end
  end
end
