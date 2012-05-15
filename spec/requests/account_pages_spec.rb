require 'spec_helper'

describe "Account pages" do
  
  subject { page }
  
  describe "signup page" do
    before {  visit signup_path }
    
    it { should have_selector('title', text: 'Sign up') }
  end
end
