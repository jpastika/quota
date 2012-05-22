require 'spec_helper'

describe CatalogItem do
  
  before { @item = CatalogItem.new(name: "Item 1", list_price: "50") }
  
  subject { @item }
  
  it { should respond_to(:name) }
  it { should respond_to(:part_number) }
  it { should respond_to(:manufacturer) }
  it { should respond_to(:description) }
  it { should respond_to(:list_price) }
  it { should respond_to(:cost) }
  it { should respond_to(:is_recurring) }
  it { should respond_to(:recurring_unit) }
  it { should respond_to(:is_taxable) }
  it { should respond_to(:is_subscription) }
  it { should respond_to(:subscription_length) }
  it { should respond_to(:subscription_length_unit) }
  it { should respond_to(:pub_key) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @item.name = " " }
    
    it { should_not be_valid }
  end
  
  
end
