require 'spec_helper'

describe "Catalog Item Pages" do
  
  subject { page }
  
  let(:user){ FactoryGirl.create(:user) }
  before {sign_in user}
  
  describe "index" do
    before do
      FactoryGirl.create(:catalog_item, account: user.account)
      visit catalog_items_path
    end
    
    it { should have_selector('title', text: 'Catalog Items') }
    it { should have_link('Add catalog item', href: new_catalog_item_path) }
    
    describe "when delete link is clicked" do
      
      it "should delete a catalog item" do
        expect { click_link "Delete" }.should change(CatalogItem, :count).by(-1)
      end
    end
  end
  
  describe "new" do
    before { visit new_catalog_item_path }
    
    it { should have_selector('title', text: 'Add Catalog Item') }
    
  end
end
