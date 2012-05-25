require 'spec_helper'

describe Opportunity do
  before { @opp = Opportunity.new(name: "Opportunity 1") }
  
  subject { @opp }
  
  it { should respond_to(:name) }
  it { should respond_to(:estimated_close) }
  it { should respond_to(:milestone_key) }
  it { should respond_to(:probability) }
  it { should respond_to(:owner_key) }
  it { should respond_to(:account) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before{ @opp.name = " " }
    
    it { should_not be_valid }
  end
end
