require 'spec_helper'

describe "Catalog Item Pages" do
  
  subject { page }
  
  before {sign_in FactoryGirl.create(:member)}
  
  describe "index" do
    before { visit catalog_items_path }
    
    it { should have_selector('title', text: 'Catalog Items') }
    it { should have_link('Add catalog item', href: new_catalog_item_path) }
  end
end
