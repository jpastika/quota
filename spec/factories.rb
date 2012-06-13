FactoryGirl.define do
  
  sequence :subdomain do |n|
    "co#{n}"
  end
  
  factory :account do
    sequence(:name)  { |n| "Company #{n}" }
    subdomain { FactoryGirl.generate(:subdomain) }
  end
  
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    
    #factory :admin do
    #  admin true
    #end
  end
  
  factory :member do
    account
    user
  end
  
  
  factory :catalog_item do
    sequence(:name)  { |n| "Item #{n}" }
    list_price 100
    account
  end
  
  factory :opportunity do
    sequence(:name)  { |n| "Opportunity #{n}" }
    created_by { FactoryGirl.create(:member) }
    owner { FactoryGirl.create(:member) }
    account
  end
  
  factory :quote do
    sequence(:name)  { |n| "Quote #{n}" }
    created_by { FactoryGirl.create(:member) }
    opportunity
    account
  end
  
end